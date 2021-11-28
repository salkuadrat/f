import 'dart:io';

import '../extension.dart';

void moduleProvider(String project, String module) {
  _directory('lib/modules/$module');
  _file('lib/modules/$module/$module.dart');
  _file('lib/modules/$module/${module}_state.dart');
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
export '${module}_state.dart';
export '${module}_service.dart';''');

  File('$dir/${module}_state.dart').writeAsStringSync('''
import 'package:flutter/foundation.dart';

import 'package:$project/modules/$module/$module.dart';

class ${prefix}State extends ChangeNotifier {

  final ${prefix}Service _service;

  ${prefix}State(this._service);

}''');

  File('$dir/${module}_service.dart').writeAsStringSync('''
class ${prefix}Service {

}''');
}

void _screen(String project, String dir, String module) {
  String prefix = module.trim().titleCase;
  File('$dir/$module.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:$project/modules/$module/$module.dart';

class $prefix extends StatelessWidget {
  const $prefix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ${prefix}State(${prefix}Service()),
      child: const ${prefix}Page(),
    );
  }
}

class ${prefix}Page extends StatelessWidget {
  const ${prefix}Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<${prefix}State>(
        builder: (_, $module, __) {
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
