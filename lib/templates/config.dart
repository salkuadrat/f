import 'dart:io';

import '../extension.dart';

/// generate template for config
void config(String project) {
  String dir = '$project/lib/config';

  _config(project, dir);
  _assets(project, dir);
  _colors(project, dir);
  _fonts(project, dir);
  _strings(project, dir);
  _styles(project, dir);
  _themes(project, dir);
}

void _config(String project, String dir) {
  File('$dir/config.dart').writeAsStringSync('''
export 'assets.dart';
export 'colors.dart';
export 'fonts.dart';
export 'strings.dart';
export 'styles.dart';
export 'themes.dart';''');
}

void _assets(String project, String dir) {
  File('$dir/assets.dart').writeAsStringSync('''
String logo = './assets/logo/logo.png';''');
}

void _colors(String project, String dir) {
  File('$dir/colors.dart').writeAsStringSync('''
import 'package:colour/colour.dart';
import 'package:flutter/material.dart';

MaterialColor primarySwatch = Colors.blue;
Color backgroundColor = Colour('#F9F9F9');
Color secondaryColor = Colour('#5E92F3');''');
}

void _fonts(String project, String dir) {
  File('$dir/fonts.dart').writeAsStringSync('''
// String openSans = './assets/fonts/OpenSans/OpenSansRegular.ttf';''');
}

void _strings(String project, String dir) {
  File('$dir/strings.dart').writeAsStringSync('''
String appName = '${project.replaceAll('_', ' ').titleCase}';
String appTitle = '${project.replaceAll('_', ' ').titleCase}';
String search = 'Search...';
String empty = 'No data.';
String failed = 'Fetching data failed.';''');
}

void _styles(String project, String dir) {
  File('$dir/styles.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

ButtonStyle homeButtonStyle = OutlinedButton.styleFrom(
  padding: const EdgeInsets.symmetric(horizontal: 18),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  ),
);''');
}

void _themes(String project, String dir) {
  File('$dir/themes.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:$project/config/config.dart';
import 'package:$project/utils/utils.dart';

ThemeData appTheme = createTheme(
  brightness: Brightness.light,
  systemOverlayStyle: SystemUiOverlayStyle.dark,
  primarySwatch: primarySwatch,
  background: backgroundColor,
  primaryText: Colors.black,
  secondaryText: Colors.white,
  accentColor: secondaryColor,
  divider: secondaryColor,
  buttonBackground: Colors.black38,
  buttonText: secondaryColor,
  disabled: secondaryColor,
  error: Colors.red,
);''');
}
