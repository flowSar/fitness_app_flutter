import 'package:w_allfit/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {super.id,
      required super.name,
      required super.email,
      super.password,
      super.token});

  UserModel fromEntity(UserEntity user) {
    return UserModel(
      name: user.name,
      email: user.email,
      password: user.password,
      token: user.token,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json, String? token) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      token: token,
    );
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      name: user.name,
      email: user.email,
      password: user.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
