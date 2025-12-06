import 'dart:convert';

import 'package:w_allfit/core/constants/constants.dart';
import 'package:w_allfit/features/workout/data/datasources/remote/user_remote_datasource.dart';
import 'package:http/http.dart' as http;

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  @override
  Future<Map<String, dynamic>> createUserWorkoutPlans(
      String token, String planId) async {
    // TODO: implement getUserWorkoutPlans
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> getUserWorkoutPlans(String token) async {
    final url = Uri.parse('$serverApiUrl/user/plans');
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'authorization': 'Bearer $token',
    });

    if (response.statusCode != 200) {
      throw Exception('load user workout plans failed: ${response.body}');
    }

    final data = jsonDecode(response.body)['data'];

    return List<Map<String, dynamic>>.from(data);
  }

  @override
  Future<List<Map<String, dynamic>>> getuserPlanSessions(
      String token, String planId) async {
    final url = Uri.parse('$serverApiUrl/user/plans/$planId/sessions');
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'authorization': 'Bearer $token',
    });

    if (response.statusCode != 200) {
      throw Exception('load plan sessions failed: ${response.body}');
    }

    final data = jsonDecode(response.body)['data'];

    return List<Map<String, dynamic>>.from(data);
  }

  @override
  Future<List<Map<String, dynamic>>> getUserPlanSessionExercises(
      String token, String sessionId) async {
    final url = Uri.parse(
        '$serverApiUrl/user/plans/sessions/$sessionId/sessionExercises');
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'authorization': 'Bearer $token',
    });

    if (response.statusCode != 200) {
      throw Exception('load plan sessions failed: ${response.body}');
    }

    final data = jsonDecode(response.body)['data'];

    return List<Map<String, dynamic>>.from(data);
  }

  @override
  Future<Map<String, dynamic>> markUserPlansessionExerciseComplete(
      String token, String sessionExerciseId) async {
    final url = Uri.parse(
        '$serverApiUrl/user/plans/session/exercise/$sessionExerciseId');
    final response = await http.put(url,
        headers: {
          'Accept': 'application/json',
          'authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'complete': 1,
        }));

    if (response.statusCode != 200) {
      throw Exception('update session Exercise failed: ${response.body}');
    }

    final data = jsonDecode(response.body)['data'];

    return data;
  }

  @override
  Future<Map<String, dynamic>> markUserPlansessionComplete(
      String token, String sessionId) async {
    final url = Uri.parse('$serverApiUrl/user/plans');
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'authorization': 'Bearer $token',
    });

    if (response.statusCode != 200) {
      throw Exception('load user workout plans failed: ${response.body}');
    }

    final data = jsonDecode(response.body)['data'];

    return data;
  }
}
