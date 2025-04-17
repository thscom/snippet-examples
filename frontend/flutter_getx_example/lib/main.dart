import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'router.dart';

void main() {
  runApp(GetMaterialApp(
      getPages: pages,
      initialRoute: '/',
    ));
}
