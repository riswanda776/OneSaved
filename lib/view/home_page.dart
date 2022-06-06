import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:one_saved/controller/account_controller.dart';
import 'package:one_saved/controller/biometric_auth_controller.dart';

import 'package:one_saved/view/account/acoount_page.dart';
import 'package:one_saved/view/favorite/favorite_page.dart';
import 'package:one_saved/view/settings/settings_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  List screens = [
    AccountPage(Get.put(AccountController())),
    FavoritePage(Get.put(AccountController())),
    SettingsPage(Get.put(BiometricController())),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(items: [
            BottomNavigationBarItem(icon: Icon(Icons.lock), label: "Acoount"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorite"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ]),
          tabBuilder: (BuildContext ctx, int index) {
            return screens[index];
          }),
    );
  }
}
