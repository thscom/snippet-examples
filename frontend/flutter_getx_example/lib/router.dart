import 'package:flutter_getx_example/pages/home.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> pages = [
  GetPage(
    name: '/',
    page: () => const HomePage(),
  )
];