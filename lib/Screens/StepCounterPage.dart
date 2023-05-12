import 'dart:io';

import 'package:fitnesspro/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // import this package for custom fonts

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class StepCounterPage extends StatefulWidget {
  const StepCounterPage({Key? key}) : super(key: key);

  @override
  _StepCounterPageState createState() => _StepCounterPageState();
}

class _StepCounterPageState extends State<StepCounterPage> {
  StreamSubscription<StepCount>? _stepCountSubscription;
  StreamSubscription<PedestrianStatus>? _pedestrianStatusSubscription;
  String _status = '?', _steps = '?';
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  @override
  void dispose() {
    _stepCountSubscription?.cancel();
    _pedestrianStatusSubscription?.cancel();
    super.dispose();
  }

  void _requestPermission() async {
    final status = await Permission.activityRecognition.request();
    setState(() {
      _permissionStatus = status;
    });

    if (status.isGranted) {
      _startStreams();
    }
  }

  void _startStreams() {
    _pedestrianStatusSubscription = Pedometer.pedestrianStatusStream
        .listen(onPedestrianStatusChanged, onError: onPedestrianStatusError);

    _stepCountSubscription = Pedometer.stepCountStream
        .listen(onStepCount, onError: onStepCountError);
  }

  void onStepCount(StepCount event) {
    if (mounted) {
      setState(() {
        _steps = event.steps.toString();
      });
    }
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    if (mounted) {
      setState(() {
        _status = event.status;
      });
    }
  }

  void onPedestrianStatusError(error) {
    if (mounted) {
      setState(() {
        _status = 'Pedestrian Status not available';
      });
    }
    print(_status);
  }

  void onStepCountError(error) {
    if (mounted) {
      setState(() {
        _steps = 'Step Count not available';
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const Text('Step Counter'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.4, 0.7, 0.9],
            colors: [
              Colors.yellow[800]!,
              Colors.yellow[700]!,
              Colors.yellow[600]!,
              Colors.yellow[400]!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Steps taken:',
                style: GoogleFonts.roboto(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                _steps,
                style: GoogleFonts.roboto(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Divider(
                height: 100,
                thickness: 0,
                color: Colors.white,
              ),
              Text(
                'Pedestrian status:',
                style: GoogleFonts.roboto(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Icon(
                _status == 'walking'
                    ? Icons.directions_walk
                    : _status == 'stopped'
                        ? Icons.accessibility_new
                        : Icons.error,
                size: 100,
                color: Colors.black87,
              ),
              Center(
                child: Text(
                  _status,
                  style: _status == 'walking' || _status == 'walking'
                      ? GoogleFonts.roboto(
                          fontSize: 30,
                          color: Colors.black87,
                        )
                      : GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                ),
              ),
              SizedBox(height: 50),
              Text(
                'Keep pushing your limits!',
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
