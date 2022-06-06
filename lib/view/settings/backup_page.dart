import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_saved/controller/account_controller.dart';
import 'package:one_saved/widgets/appbar.dart';
import 'package:path_provider/path_provider.dart';

class BackupPage extends StatefulWidget {
  const BackupPage({Key? key}) : super(key: key);

  @override
  State<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  final AccountController accountController = Get.find();
  String? path;
  FilePickerResult? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: Text("Backup & Restore"),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.backup,
              color: Colors.orange,
            ),
            onTap: (() => accountController.backupData()),
            title: Text("Backup Data"),
            subtitle: Text("backup data to local file"),
          ),
          ListTile(
            onTap: accountController.restoreData,
            leading: Icon(
              Icons.restore_from_trash_rounded,
              color: Colors.orange,
            ),
            title: Text(
              "Restore Data",
            ),
            subtitle: Text("load data from file"),
          ),
        ],
      ),
    );
  }
}
