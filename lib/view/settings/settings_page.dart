import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_saved/controller/biometric_auth_controller.dart';
import 'package:one_saved/view/settings/backup_page.dart';
import 'package:one_saved/view/settings/biometric_settings_page.dart';
import 'package:one_saved/widgets/appbar.dart';

class SettingsPage extends StatelessWidget {
  final BiometricController controller;
  const SettingsPage(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
          title: Text(
            "Settings",
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: ListView(
          children: [
            ListTile(
              onTap: (() => Get.to(() => BackupPage())),
              leading: Icon(
                Icons.backup,
                color: Colors.orange,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              title: Text("Backup & Restore"),
            ),
            ListTile(
              onTap: (() => Get.to(() => BiometricSettingDart(controller))),
              leading: Icon(
                Icons.security,
                color: Colors.orange,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              title: Text("Security"),
            ),
          ],
        ));
  }
}
