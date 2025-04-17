import 'package:faker/faker.dart';
import 'package:flutter_getx_example/model/todo.dart';
import 'package:get/get.dart';

class TodoViewModel extends GetxController {
  List<Todo> todos = []; // Observable list of todos

  Future<void> fetchTodos() async {
    // Simulate fetching todos from an API or database
    await Future.delayed(Duration(seconds: 1)); // Simulate delay
    Faker faker = Faker();
    for (int i = 0; i < 10; i++) {
      todos.add(Todo(
          id: faker.guid.guid(),
          title: faker.lorem.sentence())); // Add random todos to the list
    }
    update();
  }
  void updateComplete(int idx) {
    todos[idx].isCompleted = !todos[idx].isCompleted;
    update(); // Notify observers that the state has changed
  }
}
