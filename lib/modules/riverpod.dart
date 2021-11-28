import 'dart:io';

import '../extension.dart';

void moduleRiverpod(String project, String module) {
  _directory('lib/modules/$module');
  _file('lib/modules/$module/$module.dart');
  _file('lib/modules/$module/${module}_notifier.dart');
  _file('lib/modules/$module/${module}_provider.dart');
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
export '${module}_notifier.dart';
export '${module}_provider.dart';
export '${module}_state.dart';
export '${module}_service.dart';''');

  File('$dir/${module}_notifier.dart').writeAsStringSync('''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:$project/modules/$module/$module.dart';

class ${prefix}Notifier extends StateNotifier<${prefix}State> {
  final ${prefix}Service _service;

  ${prefix}Notifier(this._service) : super(${prefix}Initial());
}''');

  File('$dir/${module}_provider.dart').writeAsStringSync('''
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:$project/modules/$module/$module.dart';

final ${module}Provider = StateNotifierProvider<${prefix}Notifier, ${prefix}State>(
  (ref) => ${prefix}Notifier(${prefix}Service()),
);''');

  File('$dir/${module}_state.dart').writeAsStringSync('''
import 'package:equatable/equatable.dart';

abstract class ${prefix}State extends Equatable {
  const ${prefix}State();

  @override
  List<Object?> get props => [];
}

class ${prefix}Initial extends ${prefix}State {}''');

  File('$dir/${module}_service.dart').writeAsStringSync('''
class ${prefix}Service {

}''');
}

void _screen(String project, String dir, String module) {
  String prefix = module.trim().titleCase;
  File('$dir/$module.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:$project/modules/$module/$module.dart';

class $prefix extends ConsumerWidget {
  const $prefix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final $module = ref.read(${module}Provider.notifier);
    final ${module}State = ref.watch(${module}Provider);

    return Scaffold(
      body: Container(),
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
