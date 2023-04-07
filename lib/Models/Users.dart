
class Users{
  final String fullname;
  final String email;
  final String password;

  Users({required this.fullname,required this.email,required this.password});


  Map<String, dynamic> toMap() {
    return {
      'fullname': fullname,
      'email': email,
      'password': password,
    };
  }

  Users.fromMap(Map<String, dynamic> usersMap)
      : fullname = usersMap["fullname"],
        email = usersMap["email"],
        password = usersMap["password"];
}