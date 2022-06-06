import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:one_saved/controller/account_controller.dart';
import 'package:one_saved/models/account.dart';
import 'package:one_saved/widgets/appbar.dart';

import '../../controller/biometric_auth_controller.dart';
import '../account/account_detail_page.dart';

class FavoritePage extends StatelessWidget {
  final AccountController controller;
   FavoritePage(this.controller, {Key? key}) : super(key: key);

   final auth = Get.put(BiometricController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appBar(
          title: Text(
            "Favorite",
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: controller.favoriteItems.isEmpty
            ? Center(
                child: Text("No Favorite :("),
              )
            : ListView.builder(
                itemCount: controller.favoriteItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      if (auth.isBiometric.value) {
                        if (await auth.checkBiometric()) {
                          Get.to(
                              () => AccountDetailPage(controller.items[index]));
                        }
                      } else {
                        Get.to(
                            () => AccountDetailPage(controller.items[index]));
                      }
                    },
                    leading: SizedBox(
                      height: 46,
                      width: 46,
                      child: controller.favoriteItems[index].type == "other"
                          ? Image.asset("assets/icons/other.png")
                          : SvgPicture.asset(
                              "assets/icons/${controller.favoriteItems[index].type}.svg"),
                    ),
                    title: Text(controller.favoriteItems[index].name ?? ""),
                    subtitle: Text(controller.favoriteItems[index].isSingle!
                        ? "******"
                        : controller.favoriteItems[index].email ?? ""),
                    // trailing: Builder(builder: (context) {
                    //   return IconButton(
                    //     icon: controller.items[index].isFavorite ?? false
                    //         ? Icon(
                    //             Icons.favorite,
                    //             color: Colors.red,
                    //           )
                    //         : Icon(Icons.favorite_outline),
                    //     onPressed: () {
                    //       controller.setFavorite(controller.items
                    //           .indexOf(controller.items[index]));
                    //     },
                    //   );
                    // }),
                  );
                },
              ),
      ),
    );
  }
}
