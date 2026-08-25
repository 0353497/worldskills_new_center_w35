import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldskills_new_center/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: .dark(),
      title: 'WorldSkills News Center',
      home: MainPage(),
    );
  }
}
