import 'dart:io';

import '../extension.dart';

void moduleGetx(String project, String module) {
  _directory('lib/modules/$module');
  _file('lib/modules/$module/$module.dart');
  _file('lib/modules/$module/${module}_bindings.dart');
  _file('lib/modules/$module/${module}_controller.dart');
  _file('lib/modules/$module/${module}_service.dart');
  _module(project, 'lib/modules/$module', module);

  if (!File('lib/screens/$module.dart').existsSync()) {
    _file('lib/screens/$module.dart');
    _screen(project, 'lib/screens', module);
  }
}

void _module(String project, String dir, String module) {
  String prefix = module.trim().titleCase;
  File('$dir/$module.dart').writeAsStringSync('''
export '${module}_bindings.dart';
export '${module}_controller.dart';
export '${module}_service.dart';''');

  File('$dir/${module}_bindings.dart').writeAsStringSync('''
import 'package:get/get.dart';

import 'package:$project/modules/$module/$module.dart';

class ${prefix}Bindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ${prefix}Controller(${prefix}Service()));
  }
}''');

  File('$dir/${module}_controller.dart').writeAsStringSync('''
import 'package:get/get.dart';

import 'package:$project/modules/$module/$module.dart';

class ${prefix}Controller extends GetxController {

  final ${prefix}Service _service;

  ${prefix}Controller(this._service);

}''');

  File('$dir/${module}_service.dart').writeAsStringSync('''
class ${prefix}Service {

}''');
}

void _screen(String project, String dir, String module) {
  String prefix = module.trim().titleCase;
  File('$dir/$module.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:$project/modules/$module/$module.dart';

class $prefix extends StatelessWidget {
  final ${prefix}Controller $module;

  const $prefix(this.$module, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Users'),
      ),
      body: Obx(
        () {
          return Container();
        },
      ),
    );
  }
}''');
}

void _directory(String path) {
  print('  $path');
  Directory(path).createSync();
}

void _file(String path) {
  print('  $path');
  File(path).createSync();
}
