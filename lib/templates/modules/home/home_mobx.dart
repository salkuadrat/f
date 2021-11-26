import 'dart:io';

/// generate template for module home
void homeMobx(String project, String dir) {
  _home(project, dir);
  _store(project, dir);
}

void _home(String project, String dir) {
  File('$dir/home.dart').writeAsStringSync('''
export 'home_store.dart';''');
}

void _store(String project, String dir) {
  File('$dir/home_store.dart').writeAsStringSync('''
class HomeStore {
  
}''');
}
