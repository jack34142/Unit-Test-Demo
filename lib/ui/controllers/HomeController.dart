import 'package:get/get.dart';
import 'package:material3_demo/models/todo_item.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final todoList = <TodoItem>[
    TodoItem(importance: 0, checked: false, title: "importance none"),
    TodoItem(importance: 1, checked: false, title: "importance low"),
    TodoItem(importance: 2, checked: false, title: "importance medium"),
    TodoItem(importance: 3, checked: false, title: "importance high"),
  ].obs;
}