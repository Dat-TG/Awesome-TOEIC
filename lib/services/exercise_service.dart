import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ExerciseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> insertDoneExercise(List<String> listQuestionsID, String userID,
      List<String> listAnswers, List<String> listRightAnswers, int part) async {
    int correct = 0;
    for (int i = 0; i < listAnswers.length; i++) {
      if (listAnswers[i] == listRightAnswers[i]) {
        correct += 1;
      }
    }
    await firestore.collection('DoneExercises').add({
      'list_questions_id': listQuestionsID,
      'uid': userID,
      'list_answers': listAnswers,
      'part': part,
      'correct': correct,
      'list_right_answers': listRightAnswers,
      'time': DateFormat("HH:mm yyyy-MM-dd").format(DateTime.now())
    });
  }
}
