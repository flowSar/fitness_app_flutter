import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/features/settings/presentation/components/languages_dialog.dart';
import 'package:w_allfit/features/settings/presentation/provider/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool darkMode = true;
  late bool workoutReminder = true;
  late bool waterReminder = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // backgroundColor: darkMode ? Colors.black87 : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Settings",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Customize your app',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Appearance",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.dark_mode),
                        title: Text(
                          'Dark Mode',
                          style: TextStyle(),
                        ),
                        subtitle: Text(
                          'Easier on the eyes',
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                        trailing: Switch(
                          value: darkMode,
                          onChanged: (value) {
                            context.read<SettingsProvider>().toggleTheme();
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return LanguagesDialog();
                            },
                          );
                        },
                        child: ListTile(
                          leading: Icon(Icons.language),
                          title: Text(
                            'Languages',
                            style: TextStyle(),
                          ),
                          subtitle: Text(
                            'English',
                            style: TextStyle(color: Colors.grey.shade400),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Notifications",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.warning),
                        title: Text(
                          'Workout Reminders',
                          style: TextStyle(),
                        ),
                        subtitle: Text(
                          'Daily at 9:00 AM',
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                        trailing: Switch(
                          activeColor: Colors.pinkAccent,
                          value: workoutReminder,
                          onChanged: (value) {
                            setState(() {
                              workoutReminder = !workoutReminder;
                            });
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          leading: Icon(
                            Icons.water_drop,
                            color: Colors.blue,
                          ),
                          title: Text(
                            'Water Reminders',
                            style: TextStyle(),
                          ),
                          subtitle: Text(
                            'Every 2 hours',
                            style: TextStyle(color: Colors.grey.shade400),
                          ),
                          trailing: Switch(
                            activeColor: Colors.green,
                            value: waterReminder,
                            onChanged: (value) {
                              setState(() {
                                waterReminder = !waterReminder;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Support",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          leading: Icon(
                            Icons.help_outline,
                            color: Colors.red,
                          ),
                          title: Text(
                            'Help & FAQ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          leading: Icon(
                            Icons.contact_mail,
                            color: Colors.blue,
                          ),
                          title: Text(
                            'Contact Us',
                            style: TextStyle(),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          leading: Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          title: Text(
                            'Rate Us',
                            style: TextStyle(),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          leading: Icon(
                            Icons.policy,
                            color: Colors.grey,
                          ),
                          title: Text(
                            'Privacy Policy',
                            style: TextStyle(),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Support",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.info_rounded,
                          color: Colors.blue,
                        ),
                        title: Text(
                          'App Version',
                          style: TextStyle(),
                        ),
                        subtitle: Text(
                          '1.0.0',
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
