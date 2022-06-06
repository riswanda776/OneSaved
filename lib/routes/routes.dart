import 'package:get/get.dart';
import 'package:one_saved/bindings/account_binding.dart';
import 'package:one_saved/view/home_page.dart';

List<GetPage> routes = [
  
  GetPage(name: '/', page: () => HomePage(), binding: AccountBindings())

  
  ,];
