import 'package:flutter/foundation.dart';

class HomeState extends ChangeNotifier {
  int counter = 0;

  void incrementCounter() {
    counter++;
    notifyListeners();
  }
}
