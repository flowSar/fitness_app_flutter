class UserEntity {
  final int? id;
  final String name;
  final String email;
  final String? password;
  final String? token;
  UserEntity(
      {this.id,
      required this.name,
      required this.email,
      this.password,
      this.token});
}
