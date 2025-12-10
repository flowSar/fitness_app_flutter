import 'dart:convert';

import 'package:w_allfit/core/constants/constants.dart';
import 'package:w_allfit/features/workout/data/datasources/remote/workout_remote_datasource.dart';
import 'package:http/http.dart' as http;

class WorkoutRemoteDatasourceImpl extends WorkoutRemoteDatasource {
  @override
  Future<List<Map<String, dynamic>>> getPlanSessionExercises(
      String token, String planId) async {
    final url = Uri.parse('$serverApiUrl/plans/$planId/session/exercises');
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode != 200) {
      throw Exception('loading filed ${jsonDecode(response.body)}');
    }

    final data = jsonDecode(response.body)['data'];
    return List<Map<String, dynamic>>.from(data);
  }
}
