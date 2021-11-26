import 'dart:io';

/// generate template for home screen
void homeMobx(String project, String dir) {
  File('$dir/home.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:$project/config/config.dart';

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: Container(),
    );
  }
}''');
}
