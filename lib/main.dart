import 'package:firebase_core/firebase_core.dart';
import 'package:fitnesspro/Screens/AddMealPage.dart';
import 'package:fitnesspro/Screens/AddTaskPage.dart';
import 'package:fitnesspro/Screens/ExercisePage.dart';
import 'package:fitnesspro/Screens/HomePage.dart';
import 'package:fitnesspro/Screens/newWorkoutPage.dart';
import 'package:fitnesspro/Screens/Splash.dart';
import 'package:fitnesspro/Screens/StepCounterPage.dart';
import 'package:fitnesspro/Screens/TrackGoalPage.dart';
import 'package:fitnesspro/Screens/WorkoutPage.dart';
import 'package:fitnesspro/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'Screens/LoginPage.dart';
import 'Screens/RegisterPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitnessPro App',
      initialRoute: '/',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/workout': (context) => const NewWorkoutPage(),
        '/add_meal': (context) => const AddMealPage(),
        '/track_goal': (context) => const TrackGoalPage(),
        '/add_task': (context) => const AddTaskPage(),
        '/step_counter': (context) => const StepCounterPage(),
        '/exercise_page': (context) => const ExercisePage(),
      },
      theme: ThemeData(
          primaryColor: primaryColor,
          tabBarTheme: const TabBarTheme(
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Colors.white)))),
      home: const Splash(),
    );
  }
}
