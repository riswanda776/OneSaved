import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_saved/controller/account_controller.dart';
import 'package:one_saved/models/account.dart';
import 'package:one_saved/widgets/appbar.dart';

class AddAccountPage extends StatelessWidget {
  final String type;
  const AddAccountPage(this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountController>();

    final name = TextEditingController();
    final email = TextEditingController();
    final password = TextEditingController();
    final bankNumber = TextEditingController();
    final bankPin = TextEditingController(text: "");

    void saveAccount() {
       var date = DateTime.now().millisecondsSinceEpoch;
    var key = date.toString();
      controller
          .add(Account(
            key: key,
        type: type,
        name: name.text,
        isSingle: type == "crypto",
        email: type == "bank" ? bankNumber.text : email.text,
        password: type == "bank" ? bankPin.text : password.text,
        isFavorite: false,
      ))
          .then((value) {
        Get.back();
        Get.back();
      });
    }

    return Scaffold(
      appBar: appBar(
        title: const Text("Add Account"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Name",
              ),
            ),
          ),
          type == "bank"
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: bankNumber,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Bank Number",
                    ),
                  ),
                )
              : type == "crypto"
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: email,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                        ),
                      ),
                    ),
          type == "bank"
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: bankPin,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Pin",
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: password,
                    maxLines: type == "crypto" ? 7 : 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: type == "crypto"
                          ? "Mnemonic or Private Key"
                          : "Password",
                    ),
                  ),
                )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (type == "crypto") {
            if (name.text.isEmpty) {
              Get.snackbar("Warning", "fill name first",
                  backgroundColor: Colors.orange);
            } else if (password.text.isEmpty) {
              Get.snackbar("Warning", "fill password first",
                  backgroundColor: Colors.orange);
            } else {
              saveAccount();
            }
          } else if (type == "bank") {
            if (name.text.isEmpty) {
              Get.snackbar("Warning", "fill name first",
                  backgroundColor: Colors.orange);
            } else if (bankNumber.text.isEmpty) {
              Get.snackbar("Warning", "fill name first",
                  backgroundColor: Colors.orange);
            } else {
              saveAccount();
            }
          } else {
            if (name.text.isEmpty) {
              Get.snackbar("Warning", "fill name first",
                  backgroundColor: Colors.orange);
            } else if (email.text.isEmpty) {
              Get.snackbar("Warning", "fill email first",
                  backgroundColor: Colors.orange);
            } else if (password.text.isEmpty) {
              Get.snackbar("Warning", "fill password first",
                  backgroundColor: Colors.orange);
            } else {
              saveAccount();
            }
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
