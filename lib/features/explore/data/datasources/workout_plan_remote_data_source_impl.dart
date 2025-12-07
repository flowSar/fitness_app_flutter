import 'dart:convert';

import 'package:w_allfit/core/constants/constants.dart';
import 'package:w_allfit/features/explore/data/datasources/workout_plans_remote_data_source.dart';
import 'package:http/http.dart' as http;

class WorkoutPlansRemoteDataSourceImpl extends WorkoutPlansRemoteDataSource {
  @override
  Future<List<Map<String, dynamic>>> getAllWorkoutPlans() async {
    final url = Uri.parse('$serverApiUrl/plans');
    final result = await http.get(url, headers: {
      'Accept': 'application/json',
    });

    if (result.statusCode != 200) {
      final errroMesage = jsonDecode(result.body)['message'];
      throw Exception('loading plans failed: $errroMesage');
    }
    final data = jsonDecode(result.body)['data'];
    return List<Map<String, dynamic>>.from(data);
  }
}
