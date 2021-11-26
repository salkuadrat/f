import 'dart:io';

/// generate template for module auth
void authMobx(String project, String dir) {
  _auth(project, dir);
  _store(project, dir);
}

void _auth(String project, String dir) {
  File('$dir/auth.dart').writeAsStringSync('''
export 'auth_store.dart';
export 'auth_service.dart';''');
}

void _store(String project, String dir) {
  File('$dir/auth_store.dart').writeAsStringSync('''
class AuthStore {
  
}''');
}
