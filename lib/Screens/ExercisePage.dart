import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final List<Exercise> exercises = [
    Exercise(
      name: 'Push Ups',
      description:
          'Step 1: Start in a high plank position. Place hands firmly on the ground, directly under shoulders.\n\n'
          'Step 2: Lower your body until your chest nearly touches the floor.\n\n'
          'Step 3: Push your body up returning to the starting position.\n\n'
          'Step 4: Repeat.',
    ),
    Exercise(
      name: 'Sit Ups',
      description: 'Step 1: Lie down on your back.\n\n'
          'Step 2: Bend your legs and place feet firmly on the ground to stabilize your lower body.\n\n'
          'Step 3: Cross your hands to opposite shoulders or place them behind your ears without pulling on your neck.\n\n'
          'Step 4: Curl your upper body all the way up toward your knees. Exhale as you lift.\n\n'
          'Step 5: Slowly, lower yourself down, returning to your starting point. Inhale as you lower.\n\n'
          'Step 6: Repeat.',
    ),
    Exercise(
      name: 'Squats',
      description:
          'Step 1: Stand straight with feet hip-width apart. Arms down by your sides.\n\n'
          'Step 2: Sit back and down like you’re sitting into an imaginary chair.\n\n'
          'Step 3: Lower down so thighs are as parallel to the floor as possible, with knees over your ankles.\n\n'
          'Step 4: Press your weight back into your heels.\n\n'
          'Step 5: Keep your body tight and push through your heels to bring yourself back to the starting position.\n\n'
          'Step 6: Repeat.',
    ),
    Exercise(
      name: 'Lunges',
      description:
          'Step 1: Stand tall with feet hip-width apart. Engage your core.\n\n'
          'Step 2: Take a big step forward with right leg and start to shift your weight forward so heel hits the floor first.\n\n'
          'Step 3: Lower your body until right thigh is parallel to the floor and right shin is vertical.\n\n'
          'Step 4: Press into right heel to drive back up to starting position.\n\n'
          'Step 5: Repeat on the other side.',
    ),
    Exercise(
      name: 'Jumping Jacks',
      description:
          'Step 1: Stand upright with your legs together, arms at your sides.\n\n'
          'Step 2: Bend your knees slightly, and jump into the air.\n\n'
          'Step 3: As you jump, spread your legs to be about shoulder-width apart. Stretch your arms out and over your head.\n\n'
          'Step 4: Jump back to starting position.\n\n'
          'Step 5: Repeat.',
    ),
    Exercise(
      name: 'Pull Ups',
      description:
          'Step 1: Grab the pull-up bar with your palms down (shoulder-width grip).\n\n'
          'Step 2: Hang to the pull-up-bar with straight arms and your legs off the floor.\n\n'
          'Step 3: Pull yourself up by pulling your elbows down to the floor.\n\n'
          'Step 4: Go all the way up until your chin passes the be bar.\n\n'
          'Step 5: Lower yourself until your arms are straight again.\n\n'
          'Step 6: Repeat.',
    ),
    Exercise(
      name: 'Plank',
      description: 'Step 1: Get into a pushup position on the floor.\n\n'
          'Step 2: Bend your elbows 90 degrees and rest your weight on your forearms.\n\n'
          'Step 3: Your elbows should be directly beneath your shoulders, and your body should form a straight line from your head to your feet.\n\n'
          'Step 4: Hold the position for as long as you can.\n\n'
          'Step 5: Your goal should be to hold it for two minutes.',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercises'),
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(exercises[index].name),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(exercises[index].description),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Exercise {
  final String name;
  final String description;

  Exercise({required this.name, required this.description});
}
