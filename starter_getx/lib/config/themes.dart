import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:starter_getx/config/config.dart';
import 'package:starter_getx/utils/theme.dart';

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
);
