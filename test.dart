class Person {
  final String name;
  final int age;

  Person({required this.name, required this.age});

  Person copyWith({String? name, int? age}) {
    return Person(name: name ?? this.name, age: age ?? this.age);
  }
}

class Brahim extends Person {
  Brahim({required dynamic name, required dynamic age})
      : super(name: name, age: age);
}

void main() {
  late String name = "khalid";
  String name2 = name;
  name2 = 'yassin';
  print(name);
  final b = Brahim(name: "khalid", age: 4);
}
