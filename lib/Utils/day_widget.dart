import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/meal.dart';

class DayWidget extends StatelessWidget {
  final String day;

  const DayWidget({Key? key, required this.day}) : super(key: key);

  Future<List<Meal>> getMeals(String day) async {
    User? user = FirebaseAuth.instance.currentUser;
    final db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('Users')
        .doc(user!.uid)
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
          return Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                    height: 10), // add a SizedBox between each Container
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Meal meal = snapshot.data![index];
                  return Container(
                    height: 70,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE4F0F2),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                meal.mealDesc,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Calories:',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              meal.cal.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Icon(Icons.local_fire_department),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
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
