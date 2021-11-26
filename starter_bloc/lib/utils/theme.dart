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
}
