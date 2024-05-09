/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

TodoItem todoItemFromJson(String str) => TodoItem.fromJson(json.decode(str));

String todoItemToJson(TodoItem data) => json.encode(data.toJson());

class TodoItem {
    TodoItem({
        required this.importance,
        required this.checked,
        required this.title,
    });

    int importance;
    bool checked;
    String title;

    factory TodoItem.fromJson(Map<dynamic, dynamic> json) => TodoItem(
        importance: json["importance"],
        checked: json["checked"],
        title: json["title"],
    );

    Map<dynamic, dynamic> toJson() => {
        "importance": importance,
        "checked": checked,
        "title": title,
    };
}
