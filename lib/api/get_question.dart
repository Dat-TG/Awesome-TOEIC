import 'package:cloud_firestore/cloud_firestore.dart';

class GetQuestion {
  Future<QuerySnapshot> byAll() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Questions")
        .where('part_id', isEqualTo: 1)
        .get();
    // print(snapshot.docs.map((e) => print(e['images'])));
    return snapshot;
  }
}
