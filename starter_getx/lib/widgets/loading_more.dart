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
}
