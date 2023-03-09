import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ExerciseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> insertDoneExercise(List<String> listQuestionsID, String userID,
      List<String> listAnswers, int part) async {
    await firestore.collection('DoneExercises').add({
      'list_questions_id': listQuestionsID,
      'uid': userID,
      'list_answers': listAnswers,
      'part': part,
      'time': DateFormat("yyyy-MM-dd HH:mm").format(DateTime.now())
    });
  }
}
