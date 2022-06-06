import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:one_saved/models/account.dart';
import 'package:one_saved/widgets/appbar.dart';
import 'package:toast/toast.dart';

class AccountDetailPage extends StatelessWidget {
  final Account account;
  const AccountDetailPage(this.account, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: Text(account.name ?? "")),
      body: Column(
        children: [
          account.type == "crypto"
              ? SizedBox()
              : ListTile(
                  title: Text(account.type == "bank" ? "Bank Number" : "Email"),
                  subtitle: Text(account.email ?? ""),
                  trailing: IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: account.email));
                        HapticFeedback.heavyImpact();
                      },
                      icon: Icon(Icons.copy)),
                ),
          ListTile(
            title: Text(account.type == "crypto"
                ? "Mnemonic / Private Key"
                : account.type == "bank"
                    ? "PIN"
                    : "Password"),
            subtitle: Text(account.password ?? ""),
            trailing: IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: account.password));
                  HapticFeedback.heavyImpact();
                },
                icon: Icon(Icons.copy)),
          ),
        ],
      ),
    );
  }
}
