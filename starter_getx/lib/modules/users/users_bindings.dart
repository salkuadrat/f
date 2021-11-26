import 'package:get/get.dart';

import 'package:starter_getx/modules/users/users.dart';

class UsersBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UsersController(UsersService()));
  }
}
