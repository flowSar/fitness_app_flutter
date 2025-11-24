import 'package:flutter/material.dart';

class LanguagesDialog extends StatelessWidget {
  const LanguagesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Languages"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      titlePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 6),
      actionsPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      content: SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("English"),
                Checkbox(value: true, onChanged: (value) {})
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("French"),
                Checkbox(value: false, onChanged: (value) {})
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Arabic"),
                Checkbox(value: false, onChanged: (value) {})
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("select")),
      ],
    );
  }
}
