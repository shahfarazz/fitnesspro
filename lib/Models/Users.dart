class Users {
  final String name;
  final String email;
  final String phoneNo;
  final int age;
  final double height;
  final double weight;
  final String password;

  Users({
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.age,
    required this.height,
    required this.weight,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNo': phoneNo,
      'age': age,
      'height': height,
      'weight': weight,
      'password': password,
    };
  }

  Users.fromMap(Map<String, dynamic> userMap)
      : name = userMap['name'],
        email = userMap['email'],
        phoneNo = userMap['phoneNo'],
        age = userMap['age'],
        height = userMap['height'],
        weight = userMap['weight'],
        password = userMap['password'];
}
