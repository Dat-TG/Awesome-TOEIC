import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addAnswer(int id, List<String> listAnswer) {
  return FirebaseFirestore.instance
      .collection('Answers')
      .doc(id.toString())
      .set({'list_answers': listAnswer})
      .then((value) => print("Answers Added"))
      .catchError((error) => print("Failed to add answers: $error"));
}
