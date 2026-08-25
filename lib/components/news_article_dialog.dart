import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:worldskills_new_center/services/sound_service.dart';

class NewsArticleDialog extends StatefulWidget {
  const NewsArticleDialog({super.key, this.item});
  final dynamic item;
  @override
  State<NewsArticleDialog> createState() => _NewsArticleDialogState();
}

class _NewsArticleDialogState extends State<NewsArticleDialog> {
  double fontSize = 8;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ClipRRect(
        child: SizedBox(
          height: Get.height * .7,
          width: Get.width * .8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      DateFormat(
                        "HH:mm MMM dd, yyyy",
                      ).format(.parse(widget.item["date"])),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                Text(widget.item["title"], style: Get.textTheme.displaySmall),
                Expanded(
                  child: Text(
                    widget.item["content"],
                    style: TextStyle(fontSize: fontSize),
                    overflow: .clip,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        SoundService.playSound();
                        setState(() {
                          fontSize--;
                        });
                      },
                      icon: Icon(Icons.minimize),
                    ),
                    IconButton(
                      onPressed: () {
                        SoundService.playSound();
                        setState(() {
                          fontSize++;
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
