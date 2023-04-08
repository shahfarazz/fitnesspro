import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnesspro/Models/Users.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obsecureCheck1 = true;
  bool obsecureCheck2 = true;
  bool _isSubmitted = false;
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final cpassController = TextEditingController();

  Future<void> signUp() async {
    if (passController.text.trim() == cpassController.text.trim()) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(
              msg: "The password provided is too weak.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
              msg: "The account already exists for that email.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: primaryColor,
              textColor: Colors.white,
              fontSize: 16.0);
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Password miss match, Please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    final Users users = Users(
        fullname: fullnameController.text.trim(),
        email: emailController.text.trim(),
        password: passController.text.trim());
    print("user id: ${FirebaseAuth.instance.currentUser?.uid}");
    final FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("Users").doc(users.email).set(users.toMap());
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullname', users.fullname);
    await prefs.setString('email', users.email);
    await prefs.setString('password', users.password);
    Fluttertoast.showToast(
        msg: "Registered Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildFullNameField(),
                        const SizedBox(height: 20),
                        _buildEmailField(),
                        const SizedBox(height: 20),
                        _buildPasswordField(),
                        const SizedBox(height: 20),
                        _buildConfirmPasswordField(),
                        const SizedBox(height: 20),
                        _buildSubmitButton(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text('Sign Up'),
      backgroundColor: primaryColor,
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

  Widget _buildFullNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
          child: Text(
            'Full Name',
            style: TextStyle(fontSize: 15.0),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey),
          ),
          child: TextFormField(
            validator: (value) {
              if (_isSubmitted && value!.isEmpty) {
                return 'Please enter a value';
              }
              return null;
            },
            controller: fullnameController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Enter your Full Name",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
          child: Text(
            'Email',
            style: TextStyle(fontSize: 15.0),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey),
          ),
          child: TextFormField(
            validator: (value) {
              if (_isSubmitted && value!.isEmpty) {
                return 'Please enter a value';
              }
              return null;
            },
            controller: emailController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Enter your Email",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
          child: Text(
            'Password',
            style: TextStyle(fontSize: 15.0),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            bottom: 5.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey),
          ),
          child: TextFormField(
            validator: (value) {
              if (_isSubmitted && value!.isEmpty) {
                return 'Please enter a value';
              }
              return null;
            },
            controller: passController,
            obscureText: obsecureCheck1,
            decoration: const InputDecoration(
              hintText: "Enter your Password",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
          child: Text(
            'Confirm Password',
            style: TextStyle(fontSize: 15.0, color: Colors.black),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            bottom: 5.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey),
          ),
          child: TextFormField(
            validator: (value) {
              if (_isSubmitted && value!.isEmpty) {
                return 'Please enter a value';
              }
              return null;
            },
            controller: cpassController,
            obscureText: obsecureCheck2,
            decoration: const InputDecoration(
              hintText: "Enter your Password",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: 50.0,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _isSubmitted = true;
            });
            if (_formKey.currentState!.validate()) {
              signUp();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4285F4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Register Now',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
