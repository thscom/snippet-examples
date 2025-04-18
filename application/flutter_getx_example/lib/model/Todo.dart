import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Todo extends Equatable {
  String id;
  String title;
  bool isCompleted;

  Todo(
      {required this.id,
      required this.title,
      this.isCompleted = false});

  @override
  List<Object?> get props => [id, title];

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }
}
