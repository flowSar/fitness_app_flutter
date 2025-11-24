class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final int? age;
  final double? weight;
  final double? height;
  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.age,
      required this.weight,
      required this.height});
}
