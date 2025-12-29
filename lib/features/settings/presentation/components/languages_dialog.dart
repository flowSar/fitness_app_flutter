import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w_allfit/features/settings/presentation/provider/settings_provider.dart';

class LanguagesDialog extends StatefulWidget {
  const LanguagesDialog({super.key});

  @override
  State<LanguagesDialog> createState() => _LanguagesDialogState();
}

class _LanguagesDialogState extends State<LanguagesDialog> {
  late String _selectedLanguage = 'en';
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
        child: Consumer<SettingsProvider>(
          builder: (context, settings, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RadioMenuButton(
                  value: 'en',
                  groupValue: settings.local.languageCode,
                  onChanged: (value) {
                    settings.updateLanguage('en');
                  },
                  child: Text('English'),
                ),
                RadioMenuButton(
                  value: 'fr',
                  groupValue: settings.local.languageCode,
                  onChanged: (value) {
                    settings.updateLanguage('fr');
                  },
                  child: Text('Frensh'),
                ),
                RadioMenuButton(
                  value: 'ar',
                  groupValue: settings.local.languageCode,
                  onChanged: (value) {
                    settings.updateLanguage('ar');
                  },
                  child: Text('Arabic'),
                ),
              ],
            );
          },
        ),
      ),
      actions: [
        // TextButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //     child: Text("Cancel")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("select")),
      ],
    );
  }
}
