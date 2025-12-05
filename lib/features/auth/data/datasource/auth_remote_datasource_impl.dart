import 'package:w_allfit/core/constants/constants.dart';
import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class AuthRemoteDatasource {
  Future<Result<UserModel>> register(UserModel user);
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> logout(String token);
  Future<Map<String, dynamic>> isUserAuthenticated(String token);
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('${serverApiUrl}/login');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({'email': email, 'password': password}));

    if (response.statusCode != 200) {
      throw Exception('log in failed: ${response.body}');
    }
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }

  @override
  Future<Map<String, dynamic>> logout(String token) async {
    final url = Uri.parse('${serverApiUrl}/logout');
    final result = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (result.statusCode != 200) {
      throw Exception('logout failed');
    }
    final Map<String, dynamic> data = jsonDecode(result.body)['data'];
    print('logout data: ${data}');
    return data;
  }

  @override
  Future<Result<UserModel>> register(UserModel user) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> isUserAuthenticated(String token) async {
    final url = Uri.parse('${serverApiUrl}/validate-token');
    final response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode != 200) {
      throw Exception('token validation failed ${response.body}');
    }
    final Map<String, dynamic> data = jsonDecode(response.body)['data'];
    return data;
  }
}
