import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:starter_riverpod/config/config.dart';

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
}
