import 'dart:io';

import 'package:path/path.dart';

import 'modules/bloc.dart';
import 'modules/cubit.dart';
import 'modules/getx.dart';
import 'modules/provider.dart';
import 'modules/riverpod.dart';

void module(List<String> args) {
  List<String> params = args.toList();
  String directory = absolute('');
  String project = basename(directory);
  String module = params.first;

  if (Directory('lib/modules/$module').existsSync()) {
    print('');
    print('Module $module is already exist.');
    return;
  }

  String ps = File('pubspec.yaml').readAsStringSync();

  final isBloc = ps.contains('bloc:') && ps.contains('rxdart:');
  final isCubit = ps.contains('bloc:') && !ps.contains('rxdart:');
  final isGetx = ps.contains('get:');
  final isProvider = ps.contains('provider:');
  final isRiverpod = ps.contains('flutter_riverpod:');

  if (module.isNotEmpty) {
    print('');
    print('Creating $module...');

    if (isRiverpod) {
      moduleRiverpod(project, module);
    } else if (isGetx) {
      moduleGetx(project, module);
    } else if (isBloc) {
      moduleBloc(project, module);
    } else if (isCubit) {
      moduleCubit(project, module);
    } else if (isProvider) {
      moduleProvider(project, module);
    }
  }
}
