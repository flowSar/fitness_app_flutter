import 'package:shared_preferences/shared_preferences.dart';

Future<bool> hasSeenWelcomeScreen() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('seenWelcome') ?? false;
}

void setSeenWelcomeScreen() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('seenWelcome', true);
}

Future<String?> hasToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('usertoken');
}

void setToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('usertoken', token);
}

Future<bool> clearToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.remove('usertoken');
}
