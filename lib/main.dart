import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_saved/bindings/account_binding.dart';
import 'package:one_saved/models/account.dart';
import 'package:one_saved/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AccountAdapter());

  runApp(const MyApp());

  // final data = Account(
  //   type: "email",
  //   name: "Kontolodon",
  //   email: "kontolodon@gmail.com",
  //   password: "12234",
  // );

  // final data2 = Account(
  //   type: "crypto",
  //   name: "Wallet tuyul",
  //   isSingle: true,
  //   password: "12234",
  // );

  // box.put('account', data);
  // box.put('account1', data2);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'OneSaved',
      getPages: routes,
      debugShowCheckedModeBanner: false,
      initialBinding: AccountBindings(),
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.orange,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
    );
  }
}
