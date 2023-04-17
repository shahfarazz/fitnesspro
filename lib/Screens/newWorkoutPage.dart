import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Meal.dart';
import '../Utils/colors.dart';
import '../Utils/day_widget.dart';

class NewWorkoutPage extends StatefulWidget {
  const NewWorkoutPage({Key? key}) : super(key: key);

  @override
  State<NewWorkoutPage> createState() => _NewWorkoutPageState();
}

class _NewWorkoutPageState extends State<NewWorkoutPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Meal Planner'),
          backgroundColor: const Color(0xFF4285F4),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Mo'),
              Tab(text: 'Tu'),
              Tab(text: 'We'),
              Tab(text: 'Th'),
              Tab(text: 'Fr'),
              Tab(text: 'Sa'),
              Tab(text: 'Su'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DayWidget(day: 'Monday'),
            DayWidget(day: 'Tuesday'),
            DayWidget(day: 'Wednesday'),
            DayWidget(day: 'Thursday'),
            DayWidget(day: 'Friday'),
            DayWidget(day: 'Saturday'),
            DayWidget(day: 'Sunday'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF4285F4),
          onPressed: () {
            Navigator.pushNamed(context, '/add_meal');
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
