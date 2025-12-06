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
}
