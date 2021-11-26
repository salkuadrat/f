import 'package:flutter/material.dart';

import 'package:starter_riverpod/config/config.dart';

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
}
