import 'package:flutter/material.dart';
import 'package:flutter_getx_example/view/TodoItem.dart';
import 'package:flutter_getx_example/viewmodel/TodoViewModel.dart';
import 'package:get/get.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoViewModel>(
        init: TodoViewModel(),
        builder: (controller) {
          return Column(
            children: [
              ElevatedButton(
                  onPressed: () => controller.fetchTodos(),
                  child: const Text("Fetch Todos")),
              Text("${controller.todos.length}"),
              Expanded(
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: controller.todos.length,
                    itemBuilder: (BuildContext context, int index) => TodoItem(
                      id: controller.todos[index].id,
                      title: controller.todos[index].title,
                      isCompleted: controller.todos[index].isCompleted,
                      onChanged: (id) {
                        if (id == controller.todos[index].id) {
                          controller.updateComplete(index); // Call the updateComplete function with the todo id 
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
