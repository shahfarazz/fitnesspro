import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meal.dart';

class DayWidget extends StatelessWidget {
  final String day;

  const DayWidget({Key? key, required this.day}) : super(key: key);

  Future<List<Meal>> getMeals(String day) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    final db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('Users')
        .doc(email!)
        .collection("Days")
        .doc(day)
        .collection("Meals")
        .get();
    final meal = snapshot.docs.map((e) => Meal.fromMap(e)).toList();
    return meal;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Meal>>(
      future: getMeals(day),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Meal meal = snapshot.data![index];
              return ListTile(
                title: Text(meal.mealDesc),
                subtitle: Text('${meal.cal} calories'),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load meals.'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
