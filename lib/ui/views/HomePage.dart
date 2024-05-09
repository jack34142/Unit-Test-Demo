import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material3_demo/models/todo_item.dart';
import 'package:material3_demo/ui/components/bottomSheets/AddTodoBottomSheet.dart';
import 'package:material3_demo/ui/controllers/HomeController.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomePage extends GetView<HomeController>{
  @override
  Widget build(context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => ListView.builder(
            itemCount: controller.todoList.length,
            itemBuilder: (context, index){
              final item = controller.todoList[index];
              var importance = "";
              for(int i=0; i<item.importance; i++){
                importance += "!";
              }
              return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction){
                    controller.todoList.remove(item);
                    controller.todoList.refresh();
                  },
                  child: ListTile(
                    leading: Icon(item.checked ? Icons.radio_button_checked : Icons.radio_button_off,
                        color: Get.theme.primaryColor
                    ),
                    onTap: (){
                      controller.todoList[index].checked = !item.checked;
                      controller.todoList.refresh();
                    },
                    title: Text(item.title, style: Get.textTheme.bodyLarge!.copyWith(
                      decoration: item.checked ? TextDecoration.lineThrough : null,
                    )),
                    trailing: Text(importance, style: Get.textTheme.bodyLarge!.copyWith(
                        color: Colors.red
                    )),
                  )
              );
            }
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }

  _addTodo() async {
    TodoItem? item = await Get.bottomSheet(
        AddTodoBottomSheet(),
        // backgroundColor: Get.theme.scaffoldBackgroundColor,
        isScrollControlled: true
    );
    if(item != null){
      controller.todoList.add(item);
      controller.todoList.refresh();
    }
  }
}