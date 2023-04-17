import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnesspro/Models/Task.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/colors.dart';

class TrackGoalPage extends StatefulWidget {
  const TrackGoalPage({Key? key}) : super(key: key);

  @override
  State<TrackGoalPage> createState() => _TrackGoalPageState();
}

class _TrackGoalPageState extends State<TrackGoalPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Goal Tracker'),
          backgroundColor: Color(0xFF4285F4),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                text: 'Pending',
              ),
              Tab(
                text: 'Completed',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [Pending(), Completed()],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF4285F4),
          onPressed: () {
            Navigator.pushNamed(context, '/add_task');
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Pending extends StatefulWidget {
  const Pending({Key? key}) : super(key: key);

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  showAlertDialog(BuildContext context, Task task) {
    // set up the button
    Widget okButton = TextButton(
      onPressed: () {
        _confirmComplete(task);
      },
      child: const Text(
        "Yes",
        style: TextStyle(color: Colors.white),
      ),
    );
    Widget cancelButton = TextButton(
      child: const Text(
        "No",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Color(0xFF4285F4),
      title: const Text(
        "Do you really want to complete this task?",
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

  Future<List<Task>> getTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? email = prefs.getString('email');
    String uid =
        FirebaseAuth.instance.currentUser!.uid; // get current user's uid
    final db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection('Users').doc(uid).collection("Pending").get();
    final task = snapshot.docs.map((e) => Task.fromMap(e)).toList();
    return task;
  }

  void _markComplete(Task task) {
    showAlertDialog(this.context, task);
  }

  Future<void> _confirmComplete(Task task) async {
    print(task.id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? email = prefs.getString('email');
    String uid =
        FirebaseAuth.instance.currentUser!.uid; // get current user's uid
    final db1 = FirebaseFirestore.instance;
    db1
        .collection('Users')
        .doc(uid)
        .collection("Pending")
        .doc(task.id)
        .delete();

    final db = FirebaseFirestore.instance.collection("Users").doc(uid);
    db.collection("Completed").add(task.toMap()).then((result) => {
          Fluttertoast.showToast(
              msg: "Task Marked as Completed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color(0xFF4285F4),
              textColor: Colors.white,
              fontSize: 16.0)
        });

    Navigator.of(context).pop();

    setState(() {
      getTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
        future: getTask(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF4285F4),
                ),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    int value = index + 1;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //Break Fast
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "$value. ${snapshot.data![index].task}",
                                style: const TextStyle(fontSize: 25.0),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF4285F4),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  onPressed: () {
                                    _markComplete(snapshot.data![index]);
                                  },
                                  child: const Text('Mark as complete')),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Divider(
                            thickness: 2,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    );
                  });
            }
          } else if (snapshot.hasError) {
            return const Text('no data');
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF4285F4),
            ),
          );
        });
  }
}

class Completed extends StatefulWidget {
  const Completed({Key? key}) : super(key: key);

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<List<Task>> getTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    final db = FirebaseFirestore.instance;
    String uid =
        FirebaseAuth.instance.currentUser!.uid; // get current user's uid
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection('Users').doc(uid).collection("Completed").get();
    final task = snapshot.docs.map((e) => Task.fromMap(e)).toList();
    print('idher hai task');
    print(task);
    return task;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
        future: getTask(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF4285F4),
                ),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    int value = index + 1;
                    Task task = snapshot.data![index];

                    _animationController.reset();
                    _animationController.forward();

                    return SlideTransition(
                      position: _animation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Completed Task
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "$value. ${task.task}",
                                  style: const TextStyle(fontSize: 25.0),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Divider(
                              thickness: 2,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
          } else if (snapshot.hasError) {
            return const Text('no data');
          }
          return const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        });
  }
}
