import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _logout() {
    showAlertDialog(this.context);
  }

  void _workout(){
    Navigator.pushNamed(context, '/workout');
  }

  void _goalTrack(){
    Navigator.pushNamed(context, '/track_goal');
  }

  void _heightScale(){

  }

  void _stepCounter(){
    Navigator.pushNamed(context, '/step_counter');
  }

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
      backgroundColor: primaryColor,
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
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Home'),
          backgroundColor: primaryColor,
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
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Material(
                      color: primaryColor,
                      child: InkWell(
                        onTap: _workout,
                        splashColor: Colors.black26,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Ink.image(
                              image: const NetworkImage(
                                'https://img.freepik.com/free-photo/athletic-man-woman-with-dumbbells_155003-11804.jpg?w=1380&t=st=1674910766~exp=1674911366~hmac=363b5d8f2a9ef33e0b7a9b17bf222ff79e28bdba12b4fc7dc6cd9ec79bdfce79',
                              ),
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 6,),
                            const Text("Workout Diet", style: TextStyle(fontSize: 20, color: Colors.white),)
                          ],
                        ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Material(
                      color: primaryColor,
                      child: InkWell(
                        onTap: _goalTrack,
                        splashColor: Colors.black26,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Ink.image(
                              image: const NetworkImage(
                                'https://img.freepik.com/free-photo/business-strategy-success-target-goals_1421-33.jpg?w=1380&t=st=1675107283~exp=1675107883~hmac=8566f143c57826b83b20f66cc57800437fc91c6b03c367ffd2bd58a5bbcba064',
                              ),
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 6,),
                            const Text("Goal Tracker", style: TextStyle(fontSize: 20, color: Colors.white),)
                          ],
                        ),

                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Material(
                      color: primaryColor,
                      child: InkWell(
                        onTap: _stepCounter,
                        splashColor: Colors.black26,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Ink.image(
                              image: const NetworkImage(
                                'https://img.freepik.com/premium-photo/exercise-runner-black-woman-with-digital-smartwatch-track-steps-calories-counter-heart-rate-sports-health-running-monitor-fitness-app-check-wellness-training-workout-support_590464-92206.jpg?w=1380',
                              ),
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 6,),
                            const Text("Step Counter", style: TextStyle(fontSize: 20, color: Colors.white),)
                          ],
                        ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Material(
                      color: primaryColor,
                      child: InkWell(
                        onTap: _heightScale,
                        splashColor: Colors.black26,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Ink.image(
                              image: const NetworkImage(
                                'https://img.freepik.com/free-photo/boy-measured-height-with-blackboard_1150-19697.jpg?w=1380&t=st=1675111284~exp=1675111884~hmac=c5e8839960043d86faec210485758dc8595e67864d8221620b7f04e91ba4787c',
                              ),
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 6,),
                            const Text("Height Scale", style: TextStyle(fontSize: 20, color: Colors.white),)
                          ],
                        ),

                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
