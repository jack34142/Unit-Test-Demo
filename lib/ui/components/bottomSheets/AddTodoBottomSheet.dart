import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material3_demo/models/todo_item.dart';

class AddTodoBottomSheet extends StatelessWidget {
  static const TAG = "AddTodoBottomSheet";

  final TextEditingController _controller = TextEditingController();
  final Set<int> _selected = {0};

  AddTodoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Container(
        color: Get.theme.scaffoldBackgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  key: const Key("${TAG}CloseButton"),
                  icon: const Icon(Icons.close),
                  onPressed: (){
                    Get.back();
                  }
                ),
                Expanded(child: Container()),
                IconButton(
                  key: const Key("${TAG}SaveButton"),
                  onPressed: _controller.text.isNotEmpty ? (){
                    Get.back(result: TodoItem(
                        importance: _selected.first,
                        checked: false,
                        title: _controller.text
                    ));
                  } : null,
                  icon: const Icon(Icons.save)
                ),
              ],
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Content'),
              onChanged: (text){
                setState((){});
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 17),
              child: const Text("Importance"),
            ),
            SizedBox(
              width: double.infinity,
              child: SegmentedButton(
                key: const Key("${TAG}ImportanceSelector"),
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: 0, label: Text("None")),
                  ButtonSegment(value: 1, label: Text("Low")),
                  ButtonSegment(value: 2, label: Text("Medium")),
                  ButtonSegment(value: 3, label: Text("High")),
                ],
                selected: _selected,
                onSelectionChanged: (newSelected){
                  setState((){
                    _selected.clear();
                    _selected.addAll(newSelected);
                  });
                },
              ),
            )
          ],
        ),
      )
    );
  }

}