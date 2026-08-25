import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:worldskills_new_center/pages/news_list_page.dart';
import 'package:worldskills_new_center/pages/search_results_page.dart';
import 'package:worldskills_new_center/services/json_reader.dart';

class OwnDrawer extends StatefulWidget {
  const OwnDrawer({super.key});

  @override
  State<OwnDrawer> createState() => _OwnDrawerState();
}

class _OwnDrawerState extends State<OwnDrawer> {
  List skills = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController newsTitleController = TextEditingController();
  final TextEditingController skillNameController = TextEditingController();
  final TextEditingController dateEndController = TextEditingController();
  final TextEditingController dateStartController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: skills
                  .map(
                    (e) => ExpansionTile(
                      title: Text(e["name"]),
                      children: (e["skills"] as List).map((skill) {
                        return FutureBuilder(
                          future: JsonReader.getSkill(skill.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == .waiting) {
                              return CircularProgressIndicator();
                            }
                            return InkWell(
                              onTap: () => Get.to(
                                () => NewsListPage(skillId: skill),
                                preventDuplicates: false,
                              ),
                              child: Text(snapshot.data["name"].toString()),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  )
                  .toList(),
            ),
            Divider(),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text("Search"),
                        IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                      ],
                    ),
                    TextFormField(
                      key: ValueKey("news_title"),
                      controller: newsTitleController,
                      decoration: InputDecoration(hintText: "News Title"),
                      maxLength: 10,
                      validator: (value) {
                        if (value == null) return "required";
                        if (value.trim().isEmpty) return "required";
                        return null;
                      },
                    ),
                    TextFormField(
                      key: ValueKey("skill_name"),
                      controller: skillNameController,
                      maxLength: 10,
                      validator: (value) {
                        if (value == null) return "required";
                        if (value.trim().isEmpty) return "required";
                        if (value.length < 3) return "at least 3 characters";
                        return null;
                      },
                      decoration: InputDecoration(hintText: "Skills Name"),
                    ),
                    TextFormField(
                      key: ValueKey("date_start"),
                      controller: dateStartController,
                      validator: (value) {
                        if (value == null) return "required";
                        if (value.trim().isEmpty) return "required";
                        return null;
                      },
                      decoration: InputDecoration(hintText: "Start Date"),
                    ),
                    TextFormField(
                      key: ValueKey("date_end"),
                      controller: dateEndController,
                      validator: (value) {
                        if (value == null) return "required";
                        if (value.trim().isEmpty) return "required";
                        final date = DateFormat(
                          "MM/dd/yyy",
                        ).tryParse(value.trim());
                        if (date == null) {
                          return "not valid date, use format MM/dd/yyy";
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: "End Date"),
                    ),
                    Row(
                      mainAxisAlignment: .end,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              Get.to(
                                () => SearchResultsPage(
                                  title: newsTitleController.value.text.trim(),
                                  skillName: skillNameController.value.text
                                      .trim(),
                                  start: DateFormat("MM/dd/yyy").parse(
                                    dateStartController.value.text.trim(),
                                  ),
                                  end: DateFormat(
                                    "MM/dd/yyy",
                                  ).parse(dateEndController.value.text.trim()),
                                ),
                              );
                            }
                          },
                          icon: Icon(Icons.search),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void init() async {
    skills = await JsonReader.getAllSkillsData();
    setState(() {});
  }
}
