import 'dart:io';

import '../extension.dart';

void moduleBloc(String project, String module) {
  _directory('lib/modules/$module');
  _file('lib/modules/$module/$module.dart');
  _file('lib/modules/$module/${module}_bloc.dart');
  _file('lib/modules/$module/${module}_event.dart');
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
export '${module}_bloc.dart';
export '${module}_service.dart';''');

  File('$dir/${module}_bloc.dart').writeAsStringSync('''
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:starter_bloc/modules/$module/$module.dart';

part '${module}_event.dart';
part '${module}_state.dart';

class ${prefix}Bloc extends Bloc<${prefix}Event, ${prefix}State> {

  final ${prefix}Service _service;

  ${prefix}Bloc(this._service) : super(${prefix}Initial()) {
    // register your on event here
  }
}''');

  File('$dir/${module}_event.dart').writeAsStringSync('''
part of '${module}_bloc.dart';

abstract class ${prefix}Event extends Equatable {
  const ${prefix}Event();

  @override
  List<Object> get props => [];
}''');

  File('$dir/${module}_state.dart').writeAsStringSync('''
part of '${module}_bloc.dart';

abstract class ${prefix}State extends Equatable {
  const ${prefix}State();

  @override
  List<Object> get props => [];
}

class ${prefix}Initial extends ${prefix}State {}
''');

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
      create: (_) => ${prefix}Bloc(${prefix}Service()),
      child: const ${prefix}Page(),
    );
  }
}

class ${prefix}Page extends StatelessWidget {
  const ${prefix}Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<${prefix}Bloc, ${prefix}State>(
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
