import 'package:get/get.dart';

class HomeController extends GetxController {
  var _counter = 0.obs;

  int get counter => _counter.value;

  void incrementCounter() {
    _counter++;
  }

  void decrementCounter() {
    _counter--;
  }
}
