import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:encrypt/encrypt.dart' as en;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:one_saved/models/account.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AccountController extends GetxController {
  @override
  void onInit() {
    readUser();

    super.onInit();
  }

  final RxList<Account> _items = <Account>[].obs;
  final RxList<Account> _favoriteItems = <Account>[].obs;

  RxList<Account> get items => _items;
  RxList<Account> get favoriteItems => _favoriteItems;

  RxBool get isEmpthy => _items.isEmpty.obs;

  readUser() async {
    final box = await Hive.openBox<Account>('accountBox');
    box.values.toList().forEach((element) {});
    _items.addAll(box.values.toList());

    _favoriteItems
        .addAll(_items.where((acc) => acc.isFavorite == true).toList());
  }

  Future<void> add(Account account) async {
    var box = await Hive.openBox<Account>('accountBox');

    box.put(account.key, account).then((value) {
      _items.clear();
      _favoriteItems.clear();
      readUser();
    });
  }

  Future<void> delete(String key) async {
    final box = await Hive.openBox<Account>('accountBox');
    box.delete(key).then((value) {
      _items.clear();
      _favoriteItems.clear();
      readUser();
    });
  }

  Future<void> setFavorite(
    int index,
  ) async {
    _items[index].isFavorite = !_items[index].isFavorite!;
    final box = await Hive.openBox<Account>("accountBox");

    if (_items[index].isFavorite!) {
      _favoriteItems.add(_items[index]);

      box.put(_items[index].key, _items[index].copyWith(isFavorite: true));
    } else {
      box.put(_items[index].key, _items[index].copyWith(isFavorite: false));
      _favoriteItems.remove(_items[index]);
    }

    _items.refresh();
  }

  Future<void> backupData() async {
    var box = Hive.box<Account>('accountBox');

    if (box.isEmpty) {
      Get.snackbar("Message", "No data stored",
          backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      Map<String, dynamic> map = Hive.box<Account>("accountBox")
          .toMap()
          .map((key, value) => MapEntry(key.toString(), value.toJson()));

      String json = jsonEncode(map);
      final key = en.Key.fromUtf8('my 32 length key................');
      final encrypter = en.Encrypter(en.AES(key));
      final iv = en.IV.fromLength(16);
      final encrypted = encrypter.encrypt(json, iv: iv);

      // final appDir = await getExternalStorageDirectory();
      await Permission.manageExternalStorage.request();
      await Permission.storage.request();

      Directory dir;
      

      if (await Permission.manageExternalStorage.status.isGranted ||
          await Permission.storage.isGranted) {
        if (Platform.isIOS) {
          dir = await getApplicationDocumentsDirectory();
        } else {
          dir = await Directory('/storage/emulated/0/OneSaved/backup/')
              .create(recursive: true);
        }

        String formattedDate = DateTime.now()
            .toString()
            .replaceAll('.', '-')
            .replaceAll(' ', '-')
            .replaceAll(':', '-');
        String filePath = '${dir.path}OneSaved-Backup-$formattedDate.one';
        File backupFile = File(filePath);

        try {
          await backupFile.writeAsString(encrypted.base64);
          Get.snackbar("Success", "data has ben save in ${dir.path}",
              backgroundColor: Colors.green,
              colorText: Colors.white,
              duration: const Duration(seconds: 3));
        } catch (e) {
          print(e);
        }
      } else {
        Get.snackbar("Error", "please allow storage permisson",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }

  Future<void> restoreData() async {
    FilePickerResult? file;
    try {
      file = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['one']
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "please allow storage permisson",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    if (file != null) {
      File fileResult = File(file.files.single.path.toString());
      // Hive.box<Account>('accountBox').deleteFromDisk();
      final key = en.Key.fromUtf8('my 32 length key................');
      final encrypter = en.Encrypter(en.AES(key));
      final iv = en.IV.fromLength(16);
      final decrypted =
          encrypter.decrypt64(fileResult.readAsStringSync(), iv: iv);

      Map<String, dynamic> map = jsonDecode(decrypted);

      map.forEach((key, value) {
        Account account = Account.fromJson(value);
        print(account.name);
        print(value['name']);
        Hive.box<Account>('accountBox').put(account.key, account);
      });

      _items.clear();
      readUser();

      Get.snackbar("Success", "data has ben restored",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3));
    }
  }
}
