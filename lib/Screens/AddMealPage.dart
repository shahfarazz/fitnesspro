import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnesspro/Models/Meal.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Utils/colors.dart';

class AddMealPage extends StatefulWidget {
  const AddMealPage({Key? key}) : super(key: key);

  @override
  State<AddMealPage> createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final mealDescController = TextEditingController();
  final calController = TextEditingController();
  final timeController = TextEditingController();
  var _selectedDay;
  var _selectedMealType;

  late FirebaseAuth auth;
  late String uid;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    uid = auth.currentUser!.uid;
  }

  List<String> listOfDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  List<String> listOfMealType = ['BreakFast', 'Lunch', 'Dinner'];

  Future<void> _addMeal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    if (mealDescController.text.isEmpty) {
      // check if meal description is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a meal description.')),
      );
      return; // prevent meal from being added
    }

    Meal meal = Meal(
        id: 'random-id',
        day: _selectedDay,
        mealType: _selectedMealType,
        mealDesc: mealDescController.text,
        cal: calController.text.trim(),
        time: timeController.text.trim());
    final db = FirebaseFirestore.instance.collection("Users").doc(uid);
    db
        .collection("Days")
        .doc(_selectedDay)
        .collection("Meals")
        .doc(_selectedMealType)
        .set(meal.toMap())
        .then((result) => {
              Fluttertoast.showToast(
                  msg: "Meal Added",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: primaryColor,
                  textColor: Colors.white,
                  fontSize: 16.0)
            });
    setState(() {
      _selectedDay = null;
      _selectedMealType = null;
      _formKey.currentState!.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Meal'),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/workout');
          },
        ),
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
                child: Text('Day', style: TextStyle(fontSize: 15.0)),
              ),
              DaySelector(),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
                child: Text('Meal Type', style: TextStyle(fontSize: 15.0)),
              ),
              MealTypeSelector(),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
                child:
                    Text('Meal Description', style: TextStyle(fontSize: 15.0)),
              ),
              Container(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                child: TextFormField(
                  controller: mealDescController,
                  decoration: const InputDecoration(
                      hintText: "Enter Meal Description",
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
                child: Text('Calories', style: TextStyle(fontSize: 15.0)),
              ),
              Container(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                child: TextFormField(
                  controller: calController,
                  decoration: const InputDecoration(
                      hintText: "Enter Approximate Calories",
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
                child: Text('Time', style: TextStyle(fontSize: 15.0)),
              ),
              Container(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                child: TextFormField(
                  controller: timeController,
                  decoration: const InputDecoration(
                      hintText: "Enter Approximate Time in minutes",
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
                    onPressed: _addMeal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Add Meal'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget DaySelector() {
    return SizedBox(
      height: 65.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
        child: DropdownButtonFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          value: _selectedDay,
          hint: const Text(
            'Select your day',
          ),
          isExpanded: true,
          onChanged: (value) {
            setState(() {
              _selectedDay = value;
            });
          },
          onSaved: (value) {
            setState(() {
              _selectedDay = value;
            });
          },
          items: listOfDays.map((String val) {
            return DropdownMenuItem(
              value: val,
              child: Text(
                val,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget MealTypeSelector() {
    return SizedBox(
      height: 65.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
        child: DropdownButtonFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          value: _selectedMealType,
          hint: const Text(
            'Select your meal type',
          ),
          isExpanded: true,
          onChanged: (value) {
            setState(() {
              _selectedMealType = value;
            });
          },
          onSaved: (value) {
            setState(() {
              _selectedMealType = value;
            });
          },
          items: listOfMealType.map((String val) {
            return DropdownMenuItem(
              value: val,
              child: Text(
                val,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
