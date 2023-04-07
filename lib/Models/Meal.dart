import 'package:cloud_firestore/cloud_firestore.dart';

class Meal {
  final String id;
  final String day;
  final String mealType;
  final String mealDesc;
  final String cal;
  final String time;

  Meal(
      {required this.id,
      required this.day,
      required this.mealType,
      required this.mealDesc,
      required this.cal,
      required this.time});

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'mealType': mealType,
      'mealDesc': mealDesc,
      'cal': cal,
      'time': time,
    };
  }

  factory Meal.fromMap(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return Meal(
        id: document.id,
        day: data!['day'],
        mealType: data!['mealType'],
        mealDesc: data!['mealDesc'],
        cal: data!['cal'],
        time: data!['time']);
  }
}
