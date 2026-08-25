import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldskills_new_center/components/news_article_dialog.dart';
import 'package:worldskills_new_center/components/own_drawer.dart';
import 'package:worldskills_new_center/services/json_reader.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({
    super.key,
    required this.title,
    required this.skillName,
    required this.start,
    required this.end,
  });
  final String title;
  final String skillName;
  final DateTime start;
  final DateTime end;

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  List newsItems = [];
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
          Text("Search Results"),
          Expanded(
            child: ListView.builder(
              itemCount: newsItems.length,
              itemBuilder: (context, index) {
                final item = newsItems[index];
                return ListTile(
                  onTap: () => Get.dialog(NewsArticleDialog(item: item)),
                  title: Text(item["title"]),
                  subtitle: Column(
                    mainAxisSize: .min,
                    children: [
                      Text(item["skill_name"].toString(), overflow: .clip),
                      Text(item["date"]),
                    ],
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
    newsItems = await JsonReader.query(
      widget.title,
      widget.skillName,
      widget.start,
      widget.end,
    );
    setState(() {});
  }
}
