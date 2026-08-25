import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/news_article_dialog.dart';
import '../components/own_drawer.dart';
import '../services/json_reader.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key, required this.skillId});
  final String skillId;

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late List newsItems = [];
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/images/logo_ws_white_rgb.png", height: 48),
      ),
      body: Column(
        crossAxisAlignment: .center,
        children: [
          Text("News list page"),
          Expanded(
            child: ListView.builder(
              itemCount: newsItems.length,
              itemBuilder: (context, index) {
                final item = newsItems[index];
                return ListTile(
                  onTap: () => Get.dialog(NewsArticleDialog(item: item)),
                  title: Text(item["title"]),
                  subtitle: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [Text(item["skill_name"]), Text(item["date"])],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      drawer: OwnDrawer(),
    );
  }

  void init() async {
    newsItems = await JsonReader.newsOfSkill(widget.skillId);
    setState(() {});
  }
}
