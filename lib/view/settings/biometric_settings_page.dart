import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:one_saved/controller/biometric_auth_controller.dart';

import '../../widgets/appbar.dart';

class BiometricSettingDart extends StatelessWidget {
  final BiometricController controller;
  const BiometricSettingDart(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
          title: Text("Security"),
        ),
        body: Obx(() => IgnorePointer(
              ignoring: !controller.isSupport.value,
              child: Opacity(
                opacity: !controller.isSupport.value ? 0.5 : 1,
                child: SwitchListTile(
                    title: Text("Biometric Auth"),
                    value: controller.isBiometric.value,
                    onChanged: (v) {
                      controller.setBiometric(v);
                    }),
              ),
            )));
  }
}
