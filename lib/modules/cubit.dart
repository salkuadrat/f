import 'dart:io';

import '../extension.dart';

void moduleCubit(String project, String module) {
  _directory('lib/modules/$module');
  _file('lib/modules/$module/$module.dart');
  _file('lib/modules/$module/${module}_cubit.dart');
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
export '${module}_cubit.dart';
export '${module}_state.dart';
export '${module}_service.dart';''');

  File('$dir/${module}_cubit.dart').writeAsStringSync('''
import 'package:flutter_bloc/flutter_bloc.dart';

import '${module}_service.dart';
import '${module}_state.dart';

class ${prefix}Cubit extends Cubit<${prefix}State> {
  final ${prefix}Service _service;

  ${prefix}Cubit(this._service) : super(${prefix}Initial());

}''');

  File('$dir/${module}_state.dart').writeAsStringSync('''
import 'package:equatable/equatable.dart';

abstract class ${prefix}State extends Equatable {
  const ${prefix}State();

  @override
  List<Object> get props => [];
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
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:$project/modules/$module/$module.dart';

class $prefix extends StatelessWidget {
  const $prefix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ${prefix}Cubit(${prefix}Service()),
      child: const ${prefix}Page(),
    );
  }
}

class ${prefix}Page extends StatelessWidget {
  const ${prefix}Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<${prefix}Cubit, ${prefix}State>(
        builder: (context, ${module}State) {
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
