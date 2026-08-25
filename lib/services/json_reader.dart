import 'dart:convert';

import 'package:flutter/services.dart';

class JsonReader {
  static Future<List> getAllSkillsData() async {
    final json = await rootBundle.loadString(
      "assets/json_data/skills_types.json",
    );
    final data = await jsonDecode(json);
    return data["skills_type"];
  }

  static Future<dynamic> getSkill(String skillId) async {
    final json = await rootBundle.loadString("assets/json_data/skills.json");
    final List data = await jsonDecode(json);
    return data.firstWhere((e) => e["id"].toString() == skillId);
  }

  static Future<List> query(
    String newsTitle,
    String skillName,
    DateTime start,
    DateTime end,
  ) async {
    final newsJson = await rootBundle.loadString(
      "assets/json_data/news_all.json",
    );
    final List newsData = jsonDecode(newsJson);

    final skillsJson = await rootBundle.loadString(
      "assets/json_data/skills.json",
    );
    final List skillsData = jsonDecode(skillsJson);

    final normalizedTitle = newsTitle.toLowerCase().trim();
    final normalizedSkillName = skillName.toLowerCase().trim();

    // Normalize date range to full-day bounds so time-of-day doesn't exclude matches.
    final startMs = DateTime(
      start.year,
      start.month,
      start.day,
    ).millisecondsSinceEpoch;
    final endMs = DateTime(
      end.year,
      end.month,
      end.day,
      23,
      59,
      59,
      999,
    ).millisecondsSinceEpoch;

    final result = <Map<String, dynamic>>[];
    var sequence = 1;

    for (final news in newsData) {
      final title = news["title"].toString();
      final publishTime = news["publish_time"] as int;
      final skillId = news["skill_id"].toString();

      if (!title.toLowerCase().contains(normalizedTitle)) continue;

      if (publishTime < startMs || publishTime > endMs) continue;

      final skill = skillsData.firstWhere(
        (s) => s["id"].toString() == skillId,
        orElse: () => null,
      );
      if (skill == null) continue;

      final matchedSkillName = skill["name"].toString();

      if (!matchedSkillName.toLowerCase().contains(normalizedSkillName)) {
        continue;
      }

      result.add({
        "sequence": sequence++,
        "title": title,
        "date": DateTime.fromMillisecondsSinceEpoch(
          publishTime,
        ).toIso8601String(),
        "skill_name": matchedSkillName,
        "content": news["content"],
      });
    }

    return result;
  }

  static Future<List> newsOfSkill(String skillQueryId) async {
    final newsJson = await rootBundle.loadString(
      "assets/json_data/news_all.json",
    );
    final List newsData = jsonDecode(newsJson);

    final skillsJson = await rootBundle.loadString(
      "assets/json_data/skills.json",
    );
    final List skillsData = jsonDecode(skillsJson);

    final result = <Map<String, dynamic>>[];
    var sequence = 1;

    for (final news in newsData) {
      final title = news["title"].toString();
      final publishTime = news["publish_time"] as int;
      final skillId = news["skill_id"].toString();

      final skill = skillsData.firstWhere(
        (s) => s["id"].toString() == skillId,
        orElse: () => null,
      );
      if (skill == null) continue;
      if (skillId != skillQueryId) continue;

      final matchedSkillName = skill["name"].toString();

      result.add({
        "sequence": sequence++,
        "title": title,
        "date": DateTime.fromMillisecondsSinceEpoch(
          publishTime,
        ).toIso8601String(),
        "skill_name": matchedSkillName,
        "content": news["content"],
      });
    }

    return result;
  }
}
