import 'dart:io';

/// generate template for login screen
void loginMobx(String project, String dir) {
  File('$dir/login.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}''');
}
