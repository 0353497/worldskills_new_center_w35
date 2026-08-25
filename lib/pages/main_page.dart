import 'package:flutter/material.dart';
import 'package:worldskills_new_center/components/own_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/images/logo_ws_white_rgb.png", height: 48),
      ),
      body: Image.asset(
        "assets/images/main_page_post.jpg",
        height: .maxFinite,
        width: .maxFinite,
        fit: .fitHeight,
      ),
      drawer: OwnDrawer(),
    );
  }
}
