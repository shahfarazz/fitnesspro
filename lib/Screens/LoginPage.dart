import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
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
  // Key to identify the form and perform validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obsecureCheck = true;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final TapGestureRecognizer _gestureRecognizer = TapGestureRecognizer();

  Future<void> signIn() async {
    if (emailController.text.trim().isEmpty ||
        passController.text.trim().isEmpty) {
      // Display an error message if either field is empty
      Fluttertoast.showToast(
          msg: "Please enter your email and password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    try {
      // Authenticate user with Firebase Auth
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim());
      // If login was successful, save user credentials and navigate to home screen
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
      }
    } on FirebaseAuthException catch (e) {
      // Handle login errors
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30.0),
              _buildHeader(),
              const SizedBox(height: 30.0),
              _buildTitle(),
              const SizedBox(height: 10.0),
              _buildSubTitle(),
              const SizedBox(height: 30.0),
              _buildEmailFormField(),
              const SizedBox(height: 20.0),
              _buildPasswordFormField(),
              const SizedBox(height: 40.0),
              _buildLoginButton(),
              const SizedBox(height: 20.0),
              _buildSignUpButton(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Login',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFF4285F4),
      elevation: 0.0,
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 200.0,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/logo.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(150.0),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Welcome back!',
      style: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSubTitle() {
    return const Text(
      'Login to your account',
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildEmailFormField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF4285F4),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordFormField() {
    return TextFormField(
      controller: passController,
      obscureText: obsecureCheck,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF4285F4),
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obsecureCheck ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              obsecureCheck = !obsecureCheck;
            });
          },
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: () {
          signIn();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4285F4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Don\'t have an account? ',
        style: TextStyle(color: primaryColor),
        children: [
          TextSpan(
            text: 'Sign up now',
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, '/register');
              },
          ),
        ],
      ),
    );
  }
}
