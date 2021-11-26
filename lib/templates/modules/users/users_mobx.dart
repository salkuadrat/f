import 'dart:io';

/// generate template for module users
void usersMobx(String project, String dir) {
  _users(project, dir);
  _store(project, dir);
}

void _users(String project, String dir) {
  File('$dir/users.dart').writeAsStringSync('''
export 'users_store.dart';
export 'users_service.dart';''');
}

void _store(String project, String dir) {
  File('$dir/users_store.dart').writeAsStringSync('''
class UserStore {
  
}''');
}
