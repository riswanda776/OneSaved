import 'package:get/instance_manager.dart';
import 'package:one_saved/controller/account_controller.dart';

class AccountBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountController());
  }
}
