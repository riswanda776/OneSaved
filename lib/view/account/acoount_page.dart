import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:one_saved/controller/account_controller.dart';
import 'package:one_saved/controller/biometric_auth_controller.dart';
import 'package:one_saved/models/account.dart';
import 'package:one_saved/utils/color.dart';
import 'package:one_saved/view/account/account_detail_page.dart';
import 'package:one_saved/view/account/add_account_page.dart';
import 'package:one_saved/view/account/type_selection_page.dart';
import 'package:one_saved/view/favorite/favorite_page.dart';
import 'package:one_saved/widgets/appbar.dart';

class AccountPage extends StatelessWidget {
  final AccountController controller;

  AccountPage(this.controller, {Key? key}) : super(key: key);

  final auth = Get.put(BiometricController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appBar(
          title: Text(
            "Account",
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: controller.isEmpthy.value
            ? Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  SizedBox(
                    height: 350,
                    width: 500,
                    child: Image.asset("assets/icons/box_front.png"),
                  ),
                  Text(
                    "Account is empty..",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  ElevatedButton(
                      onPressed: (() => Get.to(() => TypeSelectionPage())),
                      child: Text("Add data"))
                ],
              )
            : ListView.builder(
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      onLongPress: (() => deleteBottomSheet(index)),
                      onTap: () async {
                        if (auth.isBiometric.value) {
                          if (await auth.checkBiometric()) {
                            Get.to(() =>
                                AccountDetailPage(controller.items[index]));
                          }
                        } else {
                          Get.to(
                              () => AccountDetailPage(controller.items[index]));
                        }
                      },
                      leading: SizedBox(
                        height: 46,
                        width: 46,
                        child: controller.items[index].type == "other"
                            ? Image.asset("assets/icons/other.png")
                            : SvgPicture.asset(
                                "assets/icons/${controller.items[index].type}.svg"),
                      ),
                      title: Text(controller.items[index].name ?? ""),
                      subtitle: Text(controller.items[index].isSingle!
                          ? "******"
                          : controller.items[index].email ?? ""),
                      trailing: IconButton(
                        icon: controller.items[index].isFavorite ?? false
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(Icons.favorite_outline),
                        onPressed: () async {
                          await controller.setFavorite(controller.items
                              .indexOf(controller.items[index]));
                        },
                      ));
                },
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: controller.items.isEmpty
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: FloatingActionButton(
                  onPressed: () {
                    Get.to(() => TypeSelectionPage());
                  },
                  child: Icon(Icons.add),
                ),
              ),
      ),
    );
  }

  void deleteBottomSheet(int index) {
    Get.bottomSheet(
        Container(
          child: Column(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Are you sure want to delete ${controller.items[index].name} ?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Spacer(),
              SizedBox(
                height: 200,
                width: 300,
                child: Image.asset("assets/icons/download_front.png"),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 170,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.orange),
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    width: 170,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange)),
                    child: TextButton(
                      onPressed: () {
                        controller
                            .delete(controller.items[index].key!)
                            .then((value) => Get.back());
                      },
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white);
  }
}
