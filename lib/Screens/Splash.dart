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
        () => Navigator.of(context).pushNamedAndRemoveUntil(
            (isLogin) ? '/home' : '/login', (Route<dynamic> route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/logo.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.white.withOpacity(0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Fitness Pro',
              style: TextStyle(
                color: Color(0xFF4072B7),
                fontWeight: FontWeight.w300,
                fontSize: 40,
                fontFamily: 'Supra',
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
