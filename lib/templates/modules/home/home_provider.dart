import 'dart:io';

/// generate template for module home
void homeProvider(String project, String dir) {
  _home(project, dir);
  _state(project, dir);
}

void _home(String project, String dir) {
  File('$dir/home.dart').writeAsStringSync('''
export 'home_state.dart';''');
}

void _state(String project, String dir) {
  File('$dir/home_state.dart').writeAsStringSync('''
import 'package:flutter/foundation.dart';

class HomeState extends ChangeNotifier {

  int counter = 0;

  void incrementCounter() {
    counter++;
    notifyListeners();
  }
}''');
}
