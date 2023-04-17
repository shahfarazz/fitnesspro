import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnesspro/Models/Task.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/colors.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final taskController = TextEditingController();

  Future<void> _addTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String uid =
        FirebaseAuth.instance.currentUser!.uid; // get current user's uid
    Task task = Task(id: "random.id", task: taskController.text);
    final db = FirebaseFirestore.instance.collection("Users").doc(uid);
    db.collection("Pending").add(task.toMap()).then((result) => {
          Fluttertoast.showToast(
              msg: "Pending Task Added",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: primaryColor,
              textColor: Colors.white,
              fontSize: 16.0)
        });
    setState(() {
      _formKey.currentState!.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Task'),
        backgroundColor: Color(0xFF4285F4),
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
              const Padding(
                padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
                child: Text('Task', style: TextStyle(fontSize: 15.0)),
              ),
              Container(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                child: TextFormField(
                  controller: taskController,
                  decoration: const InputDecoration(
                      hintText: "Enter Task description",
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
                    onPressed: _addTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4285F4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Add Task'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
