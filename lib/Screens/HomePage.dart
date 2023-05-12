import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // function to logout the user
  void _logout() {
    showAlertDialog(this.context);
  }

  // function to go to WorkoutDiet page
  void _mealPlan() {
    Navigator.pushNamed(context, '/workout');
  }

  // function to go to GoalTracker page
  void _goalTrack() {
    Navigator.pushNamed(context, '/track_goal');
  }

  // function to go to HeightScale page
  void _heightScale() {
    //write code to call the height scale page
    // Navigator.pushNamed(context, '/height_scale');
  }

  //write a function below to call the exercise page
  void _exercisePage() {
    //write code to call the exercise page
    Navigator.pushNamed(context, '/exercise_page');
  }

  // function to go to StepCounter page
  void _stepCounter() {
    Navigator.pushNamed(context, '/step_counter');
  }

  // function to show a logout dialog box
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text(
        "OK",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      },
    );
    Widget cancelButton = TextButton(
      child: const Text(
        "Cancel",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.lightBlue,
      title: const Text(
        "Do you really want to logout from the app?",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Center(
              // Wrap with Center
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Space the widgets evenly
                children: <Widget>[
                  mealPlannerWidget(context),
                  goalTrackerWidget(context),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              // Wrap with Center
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Space the widgets evenly
                children: <Widget>[
                  stepCounterWidget(context),
                  heightScaleWidget(context),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              // Wrap with Center
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Space the widgets evenly
                children: <Widget>[
                  exerciseMenuWidget(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _adaptiveWidget(BuildContext context, String title, String imagePath,
      VoidCallback onTap) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double width = constraints.maxWidth;
          double fontSize = MediaQuery.of(context).size.width *
              0.04; // adjust this value to your needs

          return Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.teal[300],
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
                    splashColor: Colors.black26,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: width,
                          height: 180,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(imagePath),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget mealPlannerWidget(BuildContext context) {
    return _adaptiveWidget(
        context, "Diet Plan", 'assets/images/workout_diet.JPG', _mealPlan);
  }

  Widget goalTrackerWidget(BuildContext context) {
    return _adaptiveWidget(
        context, "Goal Tracker", 'assets/images/goal_tracker.JPG', _goalTrack);
  }

  Widget stepCounterWidget(BuildContext context) {
    return _adaptiveWidget(context, "Step Counter",
        'assets/images/step_counter.JPG', _stepCounter);
  }

  Widget heightScaleWidget(BuildContext context) {
    return _adaptiveWidget(context, "Height Scale",
        'assets/images/height_scale.JPG', _heightScale);
  }

  Widget exerciseMenuWidget(BuildContext context) {
    return _adaptiveWidget(context, "Exercises",
        'assets/images/exercise_image.JPG', _exercisePage);
  }
}
