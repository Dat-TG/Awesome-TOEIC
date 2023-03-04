import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> insertUser(User? user, {String? phone}) async {
    await FirebaseFirestore.instance.collection('Users').doc(user?.uid).set(
        {'phone': phone, 'list_favourite_question_id': [], 'premium': false});
  }

  Future<dynamic> getUserByID(String id) async {
    return await FirebaseFirestore.instance.collection('Users').doc(id).get();
  }
}
