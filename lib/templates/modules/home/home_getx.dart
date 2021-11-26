import 'dart:io';

/// generate template for module home
void homeGetx(String project, String dir) {
  _home(project, dir);
  _bindings(project, dir);
  _controller(project, dir);
}

void _home(String project, String dir) {
  File('$dir/home.dart').writeAsStringSync('''
export 'home_bindings.dart';
export 'home_controller.dart';''');
}

void _bindings(String project, String dir) {
  File('$dir/home_bindings.dart').writeAsStringSync('''
import 'package:get/get.dart';

import 'package:$project/modules/home/home.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}''');
}

void _controller(String project, String dir) {
  File('$dir/home_controller.dart').writeAsStringSync('''
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
}''');
}
