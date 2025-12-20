import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_event.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_state.dart';
import 'package:w_allfit/features/settings/presentation/components/languages_dialog.dart';
import 'package:w_allfit/features/settings/presentation/provider/settings_provider.dart';
// ...existing code...

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool darkMode = true;
  late bool workoutReminder = true;
  late bool waterReminder = true;

  TextStyle get sectionTitleStyle =>
      TextStyle(fontSize: 18, fontWeight: FontWeight.w700);

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(title, style: sectionTitleStyle),
    );
  }

  Card sectionCard({required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(padding: const EdgeInsets.all(8.0), child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          centerTitle: true,
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customize your app',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
                SizedBox(height: 16),

                // Account
                sectionTitle('Account'),
                sectionCard(
                  child: BlocConsumer<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is Authenticated) {
                        if (state.isAuthenticated) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              backgroundColor: accent.withOpacity(0.12),
                              child: Icon(Icons.person, color: accent),
                            ),
                            title: Text('${state.user?.name}',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            subtitle: Text('${state.user?.email}'),
                            trailing: TextButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(LogOutEvent());
                              },
                              child: Text('Log Out'),
                            ),
                          );
                        } else {
                          return Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                  onPressed: () {}, child: Text('Log In')));
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text('Loading user account...'),
                      );
                    },
                    listener: (context, state) {
                      if (state is LogOutSuccess) {
                        context.go('/workoutScreen');
                      }
                    },
                  ),
                ),

                // Analytics
                sectionTitle('Analytics'),
                sectionCard(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        decoration: BoxDecoration(
                            color: Colors.purple.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.bar_chart, color: Colors.purple)),
                    title: Text('Reports',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('View workout history',
                        style: TextStyle(color: Colors.grey.shade500)),
                    trailing: Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () {
                      context.push('/reportsScreen');
                    },
                  ),
                ),

                // Appearance
                sectionTitle('Appearance'),
                sectionCard(
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.dark_mode, color: Colors.grey[800]),
                        ),
                        title: Text('Dark Mode'),
                        subtitle: Text('Easier on the eyes',
                            style: TextStyle(color: Colors.grey.shade500)),
                        trailing: Switch(
                          value: darkMode,
                          onChanged: (value) {
                            context.read<SettingsProvider>().toggleTheme();
                          },
                        ),
                      ),
                      Divider(),
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
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            decoration: BoxDecoration(
                                color: accent.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.language, color: accent),
                          ),
                          title: Text('Languages'),
                          subtitle: Text('English',
                              style: TextStyle(color: Colors.grey.shade500)),
                          trailing: Icon(Icons.arrow_forward_ios, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),

                // Notifications
                sectionTitle('Notifications'),
                sectionCard(
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading:
                            Icon(Icons.warning, color: Colors.orangeAccent),
                        title: Text('Workout Reminders'),
                        subtitle: Text('Daily at 9:00 AM',
                            style: TextStyle(color: Colors.grey.shade500)),
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
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.water_drop, color: Colors.blue),
                        title: Text('Water Reminders'),
                        subtitle: Text('Every 2 hours',
                            style: TextStyle(color: Colors.grey.shade500)),
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
                    ],
                  ),
                ),

                // Support
                sectionTitle('Support'),
                sectionCard(
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading:
                            Icon(Icons.help_outline, color: Colors.deepPurple),
                        title: Text('Help & FAQ',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        trailing: Icon(Icons.arrow_forward_ios, size: 18),
                        onTap: () {},
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.contact_mail, color: Colors.blue),
                        title: Text('Contact Us'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 18),
                        onTap: () {},
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.star, color: Colors.amber),
                        title: Text('Rate Us'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 18),
                        onTap: () {},
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.policy, color: Colors.grey),
                        title: Text('Privacy Policy'),
                        trailing: Icon(Icons.arrow_forward_ios, size: 18),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                // App Info
                sectionTitle('About'),
                sectionCard(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.info_rounded, color: Colors.blue),
                    title: Text('App Version'),
                    subtitle:
                        Text('1.0.0', style: TextStyle(color: Colors.grey)),
                    trailing: Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () {},
                  ),
                ),

                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// ...existing code...
