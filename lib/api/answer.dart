import 'package:cloud_firestore/cloud_firestore.dart';

class Answer {
  Future<QuerySnapshot> byID(id) async {
    QuerySnapshot answers = await FirebaseFirestore.instance
        .collection("Answers")
        .where(FieldPath.documentId, isEqualTo: id)
        .get();
    return answers;
  }
}
