import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  bool isLogin = false;

  Future<bool> checkLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('email') != null) {
      print(preferences.getString('email'));
      isLogin = true;
    }
    print(isLogin);
    return isLogin;
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
    Future.delayed(
        const Duration(seconds: 3),
            () => Navigator.of(context)
            .pushNamedAndRemoveUntil((isLogin) ? '/home' : '/login', (Route<dynamic> route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text("Fitness Pro", style: TextStyle(color: Colors.white, fontSize: 40),),
      ),
    );
  }
}
