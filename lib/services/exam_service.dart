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
