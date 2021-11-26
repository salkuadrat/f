import 'package:get/get.dart';

import 'package:starter_getx/modules/home/home.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
