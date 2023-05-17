import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ExamService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> insertDoneExam(
      String examID,
      String userID,
      List<String> listAnswers,
      List<String> listRightAnswers,
      int readingScore,
      int listeningScore) async {
    await firestore.collection('DoneExaminations').add({
      'exam_id': examID,
      'uid': userID,
      'list_answers': listAnswers,
      'list_right_answers': listRightAnswers,
      'reading_score': readingScore,
      'listening_score': listeningScore,
      'time': DateFormat("HH:mm yyyy-MM-dd").format(DateTime.now())
    });
  }
}

class HistoryExam {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<Map<String, dynamic>>> getHistoryExamofUser(String uid) async {
    QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance
        .collection('DoneExaminations')
        .where('uid', isEqualTo: uid)
        .get();
    List<Map<String, dynamic>> list = [];
    for (int i = 0; i < data.docs.length; i++) {
      list.add(data.docs[i].data());
    }
    return list;
  }
}
