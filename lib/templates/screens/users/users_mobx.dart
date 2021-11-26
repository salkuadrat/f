import 'dart:io';

/// generate template for users screen
void usersMobx(String project, String dir) {
  File('$dir/users.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

class Users extends StatelessWidget {
  const Users({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}''');
}
