import 'package:w_allfit/features/workout/domain/entities/user_entity.dart';

class UserModel extends User {
  UserModel(
      {required super.id,
      required super.name,
      required super.email,
      required super.password,
      required super.age,
      required super.weight,
      required super.height});
}
