import 'dart:io';

import 'package:fitnesspro/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class StepCounterPage extends StatefulWidget {
  const StepCounterPage({Key? key}) : super(key: key);

  @override
  _StepCounterPageState createState() => _StepCounterPageState();
}

class _StepCounterPageState extends State<StepCounterPage> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  Future<void> initPlatformState() async {
    if (Platform.isAndroid) {
      if (await Permission.activityRecognition.request().isGranted) {
        _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
        _pedestrianStatusStream
            .listen(onPedestrianStatusChanged)
            .onError(onPedestrianStatusError);

        _stepCountStream = Pedometer.stepCountStream;
        _stepCountStream.listen(onStepCount).onError(onStepCountError);

        if (!mounted) return;
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: const Text('Step Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Steps taken:',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              _steps,
              style: const TextStyle(fontSize: 60),
            ),
            const Divider(
              height: 100,
              thickness: 0,
              color: Colors.white,
            ),
            const Text(
              'Pedestrian status:',
              style: TextStyle(fontSize: 30),
            ),
            Icon(
              _status == 'walking'
                  ? Icons.directions_walk
                  : _status == 'stopped'
                      ? Icons.accessibility_new
                      : Icons.error,
              size: 100,
            ),
            Center(
              child: Text(
                _status,
                style: _status == 'walking' || _status == 'stopped'
                    ? const TextStyle(fontSize: 30)
                    : const TextStyle(fontSize: 20, color: primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
