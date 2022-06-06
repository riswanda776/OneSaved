import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';

class BiometricController extends GetxController {
  @override
  void onInit() {
    loadBiometric();
    super.onInit();
  }

  final LocalAuthentication auth = LocalAuthentication();

  RxBool isBiometric = false.obs;
  RxBool isSupport = false.obs;

  loadBiometric() async {
    final box = await Hive.openBox('biometric');
    isBiometric.value = box.get('biometric') ?? false;

    isSupport.value = await auth.isDeviceSupported();
    print("is support : ${isSupport}");
  }

  setBiometric(bool value) async {
    final box = await Hive.openBox('biometric');
    await box.put("biometric", value);
    isBiometric.value = value;
  }

  Future<bool> checkBiometric() async {
    bool isSuccess = false;
    bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    bool canAuthenticate =
        canAuthenticateWithBiometrics && await auth.isDeviceSupported();

    if (canAuthenticate) {
      try {
        final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Please authenticate to show your password');

        isSuccess = didAuthenticate;

        // ···
      } on PlatformException {
        // ...
      }
    }

    return isSuccess;
  }
}
