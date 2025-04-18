import 'package:flutter_getx_example/viewmodel/TodoViewModel.dart';
import 'package:get/get.dart';

class TodoVMBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoViewModel>(() => TodoViewModel());
  }
}
