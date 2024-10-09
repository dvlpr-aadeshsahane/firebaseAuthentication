import 'package:cloud_firestore/cloud_firestore.dart';

class DbCollections {
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
}
