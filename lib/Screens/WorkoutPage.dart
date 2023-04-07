import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Meal.dart';
import '../Utils/colors.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  var _initialIndex = 0;

  @override
  void initState() {
    DateTime date = DateTime.now();
    _initialIndex = date.weekday - 1;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _initialIndex,
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Meal Planner'),
          backgroundColor: primaryColor,
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                text: 'Mo',
              ),
              Tab(
                text: 'Tu',
              ),
              Tab(
                text: 'We',
              ),
              Tab(
                text: 'Th',
              ),
              Tab(
                text: 'Fr',
              ),
              Tab(
                text: 'Sa',
              ),
              Tab(
                text: 'Su',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Monday(),
            Tuesday(),
            Wednesday(),
            Thursday(),
            Friday(),
            Saturday(),
            Sunday(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
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

class Monday extends StatefulWidget {
  const Monday({Key? key}) : super(key: key);

  @override
  State<Monday> createState() => _MondayState();
}

class _MondayState extends State<Monday> {

  Future<List<Meal>> getMeal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    final db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('Users')
        .doc(email!)
        .collection("Days")
        .doc("Monday")
        .collection("Meals")
        .get();
    final meal = snapshot.docs.map((e) => Meal.fromMap(e)).toList();
    return meal;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Meal>>(
        future: getMeal(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    int value = index +1;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //Break Fast
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "$value.${snapshot.data![index].mealType}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, top: 10.0),
                          child: Text(
                            snapshot.data![index].mealDesc,
                            style: const TextStyle(fontSize: 15.0),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 40,
                            ),
                            Container(
                              width: 50,
                              height: 20,
                              color: Colors.grey,
                              child: Center(child: Text("${snapshot.data![index].cal}cal")),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              width: 50,
                              height: 20,
                              color: Colors.grey,
                              child: Center(child: Text("${snapshot.data![index].time}min")),
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
                    );
                  });
            }
          } else if (snapshot.hasError) {
            return const Text('no data');
          }
          return const Center(
            child:  CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        });
  }
}

class Tuesday extends StatefulWidget {
  const Tuesday({Key? key}) : super(key: key);

  @override
  State<Tuesday> createState() => _TuesdayState();
}

class _TuesdayState extends State<Tuesday> {


  Future<List<Meal>> getMeal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    final db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('Users')
        .doc(email!)
        .collection("Days")
        .doc("Tuesday")
        .collection("Meals")
        .get();
    final meal = snapshot.docs.map((e) => Meal.fromMap(e)).toList();
    return meal;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Meal>>(
        future: getMeal(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    int value = index +1;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //Break Fast
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "$value.${snapshot.data![index].mealType}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, top: 10.0),
                          child: Text(
                            snapshot.data![index].mealDesc,
                            style: const TextStyle(fontSize: 15.0),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 40,
                            ),
                            Container(
                              width: 50,
                              height: 20,
                              color: Colors.grey,
                              child: Center(child: Text("${snapshot.data![index].cal}cal")),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              width: 50,
                              height: 20,
                              color: Colors.grey,
                              child: Center(child: Text("${snapshot.data![index].time}min")),
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
                    );
                  });
            }
          } else if (snapshot.hasError) {
            return const Text('no data');
          }
          return const Center(
            child:  CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        });
  }
}

class Wednesday extends StatefulWidget {
  const Wednesday({Key? key}) : super(key: key);

  @override
  State<Wednesday> createState() => _WednesdayState();
}

class _WednesdayState extends State<Wednesday> {
  Future<List<Meal>> getMeal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    final db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('Users')
        .doc(email!)
        .collection("Days")
        .doc("Wednesday")
        .collection("Meals")
        .get();
    final meal = snapshot.docs.map((e) => Meal.fromMap(e)).toList();
    return meal;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Meal>>(
        future: getMeal(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    int value = index +1;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //Break Fast
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "$value.${snapshot.data![index].mealType}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, top: 10.0),
                          child: Text(
                            snapshot.data![index].mealDesc,
                            style: const TextStyle(fontSize: 15.0),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 40,
                            ),
                            Container(
                              width: 50,
                              height: 20,
                              color: Colors.grey,
                              child: Center(child: Text("${snapshot.data![index].cal}cal")),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              width: 50,
                              height: 20,
                              color: Colors.grey,
                              child: Center(child: Text("${snapshot.data![index].time}min")),
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
                    );
                  });
            }
          } else if (snapshot.hasError) {
            return const Text('no data');
          }
          return const Center(
            child:  CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        });
  }
}

class Thursday extends StatefulWidget {
  const Thursday({Key? key}) : super(key: key);

  @override
  State<Thursday> createState() => _ThursdayState();
}

class _ThursdayState extends State<Thursday> {
  Future<List<Meal>> getMeal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    final db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('Users')
        .doc(email!)
        .collection("Days")
        .doc("Thursday")
        .collection("Meals")
        .get();
    final meal = snapshot.docs.map((e) => Meal.fromMap(e)).toList();
    return meal;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Meal>>(
        future: getMeal(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    int value = index +1;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //Break Fast
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "$value.${snapshot.data![index].mealType}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, top: 10.0),
                          child: Text(
                            snapshot.data![index].mealDesc,
                            style: const TextStyle(fontSize: 15.0),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 40,
                            ),
                            Container(
                              width: 50,
                              height: 20,
                              color: Colors.grey,
                              child: Center(child: Text("${snapshot.data![index].cal}cal")),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              width: 50,
                              height: 20,
                              color: Colors.grey,
                              child: Center(child: Text("${snapshot.data![index].time}min")),
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
                    );
                  });
            }
          } else if (snapshot.hasError) {
            return const Text('no data');
          }
          return const Center(
            child:  CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        });
  }
}

class Friday extends StatefulWidget {
  const Friday({Key? key}) : super(key: key);

  @override
  State<Friday> createState() => _FridayState();
}

class _FridayState extends State<Friday> {
  Future<List<Meal>> getMeal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    final db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('Users')
        .doc(email!)
        .collection("Days")
        .doc("Friday")
        .collection("Meals")
        .get();
    final meal = snapshot.docs.map((e) => Meal.fromMap(e)).toList();
    return meal;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Meal>>(
        future: getMeal(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    int value = index +1;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //Break Fast
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "$value.${snapshot.data![index].mealType}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, top: 10.0),
                          child: Text(
                            snapshot.data![index].mealDesc,
                            style: const TextStyle(fontSize: 15.0),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 40,
                            ),
                            Container(
                              width: 50,
                              height: 20,
                              color: Colors.grey,
                              child: Center(child: Text("${snapshot.data![index].cal}cal")),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              width: 50,
                              height: 20,
                              color: Colors.grey,
                              child: Center(child: Text("${snapshot.data![index].time}min")),
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
                    );
                  });
            }
          } else if (snapshot.hasError) {
            return const Text('no data');
          }
          return const Center(
            child:  CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        });
  }
}

class Saturday extends StatefulWidget {
  const Saturday({Key? key}) : super(key: key);

  @override
  State<Saturday> createState() => _SaturdayState();
}

class _SaturdayState extends State<Saturday> {
  Future<List<Meal>> getMeal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    final db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('Users')
        .doc(email!)
        .collection("Days")
        .doc("Saturday")
        .collection("Meals")
        .get();
    final meal = snapshot.docs.map((e) => Meal.fromMap(e)).toList();
    return meal;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Meal>>(
        future: getMeal(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    int value = index +1;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //Break Fast
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "$value.${snapshot.data![index].mealType}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, top: 10.0),
                          child: Text(
                            snapshot.data![index].mealDesc,
                            style: const TextStyle(fontSize: 15.0),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 40,
                            ),
                            Container(
                              width: 50,
                              height: 20,
                              color: Colors.grey,
                              child: Center(child: Text("${snapshot.data![index].cal}cal")),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              width: 50,
                              height: 20,
                              color: Colors.grey,
                              child: Center(child: Text("${snapshot.data![index].time}min")),
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
                    );
                  });
            }
          } else if (snapshot.hasError) {
            return const Text('no data');
          }
          return const Center(
            child:  CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        });
  }
}

class Sunday extends StatefulWidget {
  const Sunday({Key? key}) : super(key: key);

  @override
  State<Sunday> createState() => _SundayState();
}

class _SundayState extends State<Sunday> {
  Future<List<Meal>> getMeal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    final db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('Users')
        .doc(email!)
        .collection("Days")
        .doc("Sunday")
        .collection("Meals")
        .get();
    final meal = snapshot.docs.map((e) => Meal.fromMap(e)).toList();
    return meal;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Meal>>(
        future: getMeal(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    int value = index +1;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //Break Fast
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "$value.${snapshot.data![index].mealType}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, top: 10.0),
                          child: Text(
                            snapshot.data![index].mealDesc,
                            style: const TextStyle(fontSize: 15.0),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 40,
                            ),
                            Container(
                              width: 50,
                              height: 20,
                              color: Colors.grey,
                              child: Center(child: Text("${snapshot.data![index].cal}cal")),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              width: 50,
                              height: 20,
                              color: Colors.grey,
                              child: Center(child: Text("${snapshot.data![index].time}min")),
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
                    );
                  });
            }
          } else if (snapshot.hasError) {
            return const Text('no data');
          }
          return const Center(
            child:  CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        });
  }
}
