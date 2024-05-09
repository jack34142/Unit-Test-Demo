import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material3_demo/ui/views/HomePage.dart';

void main() {
  if (!kDebugMode) {
    debugPrint = (String? message, {int? wrapWidth}) => null;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: kDebugMode,
      // navigatorKey: Get.key,
      // navigatorObservers: [
      //   //GetObserver(),
      // ],
      title: 'Material3 Demo',
      theme: ThemeData(useMaterial3: true),
      popGesture: true,
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => HomePage(), binding: HomeBinding()),
      ],
    );
  }
}