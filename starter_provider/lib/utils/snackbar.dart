import 'package:flutter/material.dart';

extension BuildContextSnackbar on BuildContext {
  void snackbar(String message) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
