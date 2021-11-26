import 'package:get/get.dart';

import 'package:starter_getx/modules/auth/auth.dart';

class AuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(AuthService()));
  }
}
