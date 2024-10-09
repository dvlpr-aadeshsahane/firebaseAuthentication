import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';

class TaskController extends ChangeNotifier {
  static TaskController instance = TaskController.internal();
  TaskController.internal();
  factory TaskController() => instance;

  List<Map<String, dynamic>> tasks = [];

  addTask({title, subtitle}) {
    FirebaseFirestore.instance.collection("tasks").add({
      'title': title,
      'subtitle': subtitle,
      'completed': false,
      'uid': AuthController().uid,
      'time_created': DateTime.now().millisecondsSinceEpoch
    });
  }

  fetchTask() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('tasks')
        .where('uid', isEqualTo: AuthController().uid)
        .orderBy('completed', descending: true)
        .orderBy('time_created', descending: true)
        .get();
    snapshot.docs.forEach((doc) {
      logger.d(doc.data());
      tasks.add(doc.data() as Map<String, dynamic>);
      notifyListeners();
    });
  }
}
