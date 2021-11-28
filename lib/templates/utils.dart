import 'dart:io';

/// generate template for utils
void utils(String project) {
  String dir = '$project/lib/utils';

  _utils(project, dir);
  _navigation(project, dir);
  _prefs(project, dir);
  _snackbar(project, dir);
  _theme(project, dir);
}

void _utils(String project, String dir) {
  File('$dir/utils.dart').writeAsStringSync('''
export 'navigation.dart';
export 'prefs.dart';
export 'snackbar.dart';
export 'theme.dart';''');
}

void _navigation(String project, String dir) {
  File('$dir/navigation.dart').writeAsStringSync('''
import 'package:flutter/widgets.dart';

extension BuildContextNavigation on BuildContext {
  Future<T?> push<T extends Object?>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<T?> replace<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }
}''');
}

void _snackbar(String project, String dir) {
  File('$dir/snackbar.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

extension BuildContextSnackbar on BuildContext {
  void snackbar(String message) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}''');
}

void _prefs(String project, String dir) {
  File('$dir/prefs.dart').writeAsStringSync('''
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences? _prefs;

  static Future _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<Set<String>> getKeys() async {
    await _init();
    return _prefs!.getKeys();
  }

  static Future<Object?> get(String key) async {
    await _init();
    return _prefs!.get(key);
  }

  static Future<bool?> getBool(String key) async {
    await _init();
    return _prefs!.getBool(key);
  }

  static Future<int?> getInt(String key) async {
    await _init();
    return _prefs!.getInt(key);
  }

  static Future<double?> getDouble(String key) async {
    await _init();
    return _prefs!.getDouble(key);
  }

  static Future<String?> getString(String key) async {
    await _init();
    return _prefs!.getString(key);
  }

  static Future<bool> containsKey(String key) async {
    await _init();
    return _prefs!.containsKey(key);
  }

  static Future<List<String>?> getStringList(String key) async {
    await _init();
    return _prefs!.getStringList(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    await _init();
    return await _prefs!.setBool(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    await _init();
    return await _prefs!.setInt(key, value);
  }

  static Future<bool> setDouble(String key, double value) async {
    await _init();
    return await _prefs!.setDouble(key, value);
  }

  static Future<bool> setString(String key, String value) async {
    await _init();
    return await _prefs!.setString(key, value);
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    await _init();
    return await _prefs!.setStringList(key, value);
  }

  static Future<bool> remove(String key) async {
    await _init();
    return await _prefs!.remove(key);
  }

  static Future<bool> clear() async {
    await _init();
    return await _prefs!.clear();
  }

  static Future<void> reload() async {
    await _init();
    await _prefs!.reload();
  }
}''');
}

void _theme(String project, String dir) {
  File('$dir/theme.dart').writeAsStringSync('''
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData createTheme({
  required Brightness brightness,
  required MaterialColor primarySwatch,
  required SystemUiOverlayStyle systemOverlayStyle,
  required Color background,
  required Color primaryText,
  required Color secondaryText,
  required Color accentColor,
  Color? divider,
  Color? buttonBackground,
  required Color buttonText,
  Color? cardBackground,
  Color? disabled,
  required Color error,
  String fontFamily = '',
}) {
  return ThemeData(
    brightness: brightness,
    primarySwatch: primarySwatch,
    canvasColor: background,
    cardColor: background,
    dividerColor: divider,
    dividerTheme: DividerThemeData(
      color: divider,
      space: 1,
      thickness: 1,
    ),
    cardTheme: CardTheme(
      color: cardBackground,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
    ),
    backgroundColor: background,
    primaryColor: accentColor,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: accentColor,
      selectionColor: accentColor,
      selectionHandleColor: accentColor,
    ),
    toggleableActiveColor: accentColor,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: systemOverlayStyle,
      color: cardBackground,
      titleTextStyle: TextStyle(
        color: secondaryText,
        fontFamily: fontFamily,
        fontSize: 18,
      ),
      toolbarTextStyle: TextStyle(
        color: secondaryText,
        fontFamily: fontFamily,
        fontSize: 18,
      ),
      iconTheme: IconThemeData(
        color: secondaryText,
      ),
    ),
    iconTheme: IconThemeData(
      color: secondaryText,
      size: 16.0,
    ),
    errorColor: error,
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: accentColor,
        primaryVariant: accentColor,
        secondary: accentColor,
        secondaryVariant: accentColor,
        surface: background,
        background: background,
        error: error,
        onPrimary: buttonText,
        onSecondary: buttonText,
        onSurface: buttonText,
        onBackground: buttonText,
        onError: buttonText,
      ),
      padding: const EdgeInsets.all(16.0),
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      brightness: brightness,
      primaryColor: accentColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: TextStyle(
        color: error,
      ),
      labelStyle: TextStyle(
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
        color: primaryText.withOpacity(0.5),
      ),
      hintStyle: TextStyle(
        color: secondaryText,
        fontSize: 13.0,
        fontWeight: FontWeight.w300,
      ),
    ),
    fontFamily: fontFamily,
  );
}''');
}
