import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String task;

  Task({
    required this.id,
    required this.task,
  });

  Map<String, dynamic> toMap() {
    return {
      'task': task,
    };
  }

  factory Task.fromMap(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return Task(
      id: document.id,
      task: data!['task'],
    );
  }
}
