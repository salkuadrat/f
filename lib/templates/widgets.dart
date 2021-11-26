import 'dart:io';

/// generate template for widgets
void widgets(String project) {
  String dir = '$project/lib/widgets';

  _buttons(project, dir);
  _cachedImage(project, dir);
  _error(project, dir);
  _logo(project, dir);
  _loadingMore(project, dir);
  _userItem(project, dir);
}

void _buttons(String project, String dir) {
  File('$dir/buttons.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String? text;
  final double? width;
  final void Function(BuildContext) onLogin;

  const LoginButton(this.text, {Key? key, this.width, required this.onLogin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      width: width,
      elevation: 2.4,
      radius: 40.0,
      text: text,
      background: Colors.lightBlue,
      gradientColors: [Colors.lightBlue, Colors.lightBlue[800]!],
      onPressed: () => onLogin(context),
    );
  }
}

class BaseButton extends StatelessWidget {
  /// This is a builder class for a nice button
  ///
  /// Icon can be used to define the button design
  /// User can use Flutter built-in Icons or font-awesome flutter's Icon  final bool mini;
  final IconData? icon;

  /// specify the color of the icon
  final Color? iconColor;

  /// radius can be used to specify the button border radius
  final double radius;

  /// List of gradient colors to define the gradients
  final List<Color> gradientColors;

  /// This is the button's text
  final String? text;

  /// This is the color of the button's text
  final Color? textColor;

  /// User can define the background color of the button
  final Color? background;

  /// User can define the width of the button
  final double? width;

  /// Here user can define what to do when the button is clicked or pressed
  final void Function()? onPressed;

  /// This is the elevation of the button
  final double elevation;

  /// This is the padding of the button
  final EdgeInsets? padding;

  /// `mini` tag is used to switch from a full-width button to a small button
  final bool mini;

  /// This is the font size of the text
  final double fontSize;

  final String fontFamily;

  final FontWeight fontWeight;

  const BaseButton({
    Key? key,
    this.mini = false,
    this.radius = 4.0,
    this.elevation = 1.8,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.width,
    this.padding = const EdgeInsets.all(12.0),
    @required this.onPressed,
    @required this.text,
    @required this.background,
    this.gradientColors = const [],
    this.icon,
    this.fontSize = 15.0,
    this.fontFamily = '',
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  bool get existGradientColors => gradientColors.isNotEmpty;

  LinearGradient get linearGradient => existGradientColors
      ? LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.topRight)
      : LinearGradient(colors: [background!, background!]);

  BoxDecoration get boxDecoration => BoxDecoration(
        gradient: linearGradient,
        borderRadius: BorderRadius.circular(radius),
        color: background,
      );

  TextStyle get textStyle => TextStyle(
        fontFamily: fontFamily,
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      );

  Widget createContainer(BuildContext context) => mini
      ? Container(
          decoration: boxDecoration,
          width: width ?? MediaQuery.of(context).size.width / 1.5,
          height: width ?? 65.0,
          child: Icon(icon, color: iconColor ?? Colors.white),
        )
      : Container(
          padding: padding,
          decoration: boxDecoration,
          constraints: BoxConstraints(
              maxWidth: width ?? MediaQuery.of(context).size.width / 1.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text ?? '',
                textAlign: TextAlign.center,
                style: textStyle,
              ),
              if (icon != null)
                Icon(
                  icon,
                  color: Colors.white,
                ),
            ],
          ),
        );

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      onPressed: onPressed,
      child: Material(
        color: Colors.transparent,
        type: MaterialType.card,
        borderRadius: BorderRadius.circular(radius),
        key: key,
        elevation: elevation,
        child: createContainer(context),
      ),
    );
  }
}''');
}

void _cachedImage(String project, String dir) {
  File('$dir/cached_image.dart').writeAsStringSync('''
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  final String imageUrl;
  final BoxFit fit;
  final double? height;
  final double? width;
  final Widget? placeholder;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      height: height,
      width: width,
      placeholder: (context, url) =>
          placeholder ?? const CircularProgressIndicator(),
      errorWidget: (context, url, err) =>
          errorWidget ?? const Icon(Icons.error_outline),
    );
  }
}''');
}

void _error(String project, String dir) {
  File('$dir/error.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:$project/config/config.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  final void Function() onRefresh;

  const ErrorMessage(
    this.message, {
    Key? key,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, style: Theme.of(context).textTheme.subtitle1),
          const Gap(6),
          OutlinedButton(
            onPressed: onRefresh,
            child: const Text('Refresh'),
            style: homeButtonStyle,
          ),
        ],
      ),
    );
  }
}''');
}

void _logo(String project, String dir) {
  File('$dir/logo.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

import 'package:$project/config/config.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
    this.size = 180,
    this.opacity = 1.0,
  }) : super(key: key);

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Image.asset(logo, width: size, height: size),
    );
  }
}''');
}

void _loadingMore(String project, String dir) {
  File('$dir/loading_more.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

class LoadingMore extends StatelessWidget {
  const LoadingMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 24,
        height: 24,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: const CircularProgressIndicator(strokeWidth: 3),
      ),
    );
  }
}''');
}

void _userItem(String project, String dir) {
  File('$dir/user_item.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

import 'package:$project/models/user.dart';

class UserItem extends StatelessWidget {
  final User user;

  const UserItem(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 20,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        leading: ClipOval(
          child: Container(
            color: Colors.grey.withOpacity(0.25),
            padding: const EdgeInsets.all(10),
            child: const Icon(Icons.person),
          ),
        ),
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: user.isActive ? const Icon(Icons.check) : null,
      ),
    );
  }
}''');
}
