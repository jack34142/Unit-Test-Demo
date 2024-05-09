// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material3_demo/main.dart';
import 'package:material3_demo/ui/components/bottomSheets/AddTodoBottomSheet.dart';

void main() async {
  testWidgets('HomePage test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    final addTodoButton = find.byType(FloatingActionButton);
    final todoListView = find.byType(ListView);
    expect(addTodoButton, findsOneWidget);
    expect(todoListView, findsOneWidget);

    var todoListViewWidget = tester.firstWidget<ListView>(todoListView);
    final todoListItemCount = todoListViewWidget.semanticChildCount ?? 0;  //記住原本的item數量

    await tester.tap(addTodoButton); // click addTodoButton
    await tester.pumpAndSettle();
    final addTodoBottomSheet = find.byType(AddTodoBottomSheet);
    expect(addTodoBottomSheet, findsOneWidget); // is AddTodoBottomSheet show

    final closeButton = find.byKey(const Key("${AddTodoBottomSheet.TAG}CloseButton"));
    expect(closeButton, findsOneWidget);

    await tester.tap(closeButton); // click closeButton
    await tester.pumpAndSettle();
    expect(addTodoBottomSheet, findsNothing); // is AddTodoBottomSheet dismiss

    await tester.tap(addTodoButton);
    await tester.pumpAndSettle();
    expect(addTodoBottomSheet, findsOneWidget); // is AddTodoBottomSheet show

    final textField = find.byType(TextField);
    final saveButton = find.byKey(const Key("${AddTodoBottomSheet.TAG}SaveButton"));
    final importanceSelector = find.byKey(const Key("${AddTodoBottomSheet.TAG}ImportanceSelector"));
    final importanceButtons = find.descendant(of: importanceSelector, matching: find.byType(Text));
    expect(textField, findsOneWidget);
    expect(importanceSelector, findsOneWidget);
    expect(saveButton, findsOneWidget);
    expect(importanceButtons, findsNWidgets(4));  //找到4個重要性分級

    final importanceSelectorWidget = tester.firstWidget<SegmentedButton>(importanceSelector);
    for (int i=0; i<4; i++) {  //點擊 importance 4 個按鈕
      await tester.tapAt( tester.getCenter(importanceButtons.at(i)) );
      expect(importanceSelectorWidget.selected, {i});  //確定widget反應正常
    }

    await tester.enterText(textField, 'Hello, World!');  // textField 輸入文字
    await tester.pumpAndSettle();
    expect(find.text('Hello, World!'), findsOneWidget);

    await tester.tap(saveButton);  // 儲存
    await tester.pumpAndSettle();
    expect(addTodoBottomSheet, findsNothing); // is AddTodoBottomSheet dismiss

    // 儲存後 listCount 應該要多一個
    todoListViewWidget = tester.firstWidget<ListView>(todoListView);
    expect(todoListViewWidget.semanticChildCount, todoListItemCount+1);

    final todoItems = find.descendant(of: todoListView, matching: find.byType(ListTile));
    var todoIcon = find.descendant(of: todoItems.last, matching: find.byIcon(Icons.radio_button_off));
    expect(todoIcon, findsOneWidget);  // 確定 checkbox icon 是 off 的

    await tester.tapAt( tester.getCenter(todoItems.last) );  //點擊 list item
    await tester.pumpAndSettle();
    todoIcon = find.descendant(of: todoItems.last, matching: find.byIcon(Icons.radio_button_checked));
    expect(todoIcon, findsOneWidget);  // 確定 checkbox icon 是 on 的

    await tester.drag(todoItems.last, const Offset(-400, 0));  // list item 左滑
    await tester.pumpAndSettle();

    // item滑掉後 listCount 應該要少一個
    todoListViewWidget = tester.firstWidget<ListView>(todoListView);
    expect(todoListViewWidget.semanticChildCount, todoListItemCount);
  });
}
