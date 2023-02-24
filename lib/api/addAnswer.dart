import 'package:cloud_firestore/cloud_firestore.dart';

Future<int> addAnswer(List<String> listAnswer) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var documents = await firestore.collection("Answers").get();
  int id = documents.size + 1;

  await firestore
      .collection('Answers')
      .doc(id.toString())
      .set({'list_answers': listAnswer})
      .then((value) => print("Answers Added"))
      .catchError((error) => print("Failed to add answers: $error"));
  return id;
}
