import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obsecureCheck = true;
  final emailController = TextEditingController();
  final passController = TextEditingController();

  Future<void> signIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "No user found for that email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "Wrong email/password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: primaryColor,
            textColor: Colors.white,
            fontSize: 16.0);
        print('Wrong password provided for that user.');
      }
    }
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', emailController.text.trim());
      await prefs.setString('password', passController.text.trim());
      Fluttertoast.showToast(
          msg: "Successful login",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
        backgroundColor: primaryColor,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const Center(
                  child: Text(
                'Fitness Pro',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
                child: Text('Email', style: TextStyle(fontSize: 15.0)),
              ),
              Container(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      hintText: "Enter your Email",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: primaryColor),
                      )),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
                child: Text('Password', style: TextStyle(fontSize: 15.0)),
              ),
              Container(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                child: TextFormField(
                  controller: passController,
                  obscureText: obsecureCheck,
                  decoration: const InputDecoration(
                      hintText: "Enter your Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1, color: primaryColor),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: signIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Login'),
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: const Text(
                    'Not a registered user? Sign up now',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
