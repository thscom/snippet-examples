import 'package:flutter/material.dart';
import 'package:flutter_getx_example/view/TodoList.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:TodoList(),
    );
  }
}
