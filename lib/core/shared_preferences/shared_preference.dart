import 'package:intl/intl.dart';
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

Future<List<String>> userLogDates() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('userLogDates') ?? [];
}

Future<void> setUserLogDates() async {
  final prefs = await SharedPreferences.getInstance();
  final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<String> dates = await userLogDates();
  if (!dates.contains(currentDate)) {
    await prefs.setStringList('userLogDates', [...dates, currentDate]);
  }
}
