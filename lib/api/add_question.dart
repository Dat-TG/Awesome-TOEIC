import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toeic_app/api/add_answer.dart';

Future<void> addQuestion(
    int id,
    List<String> listQuestion,
    List<List<String>> listAnswers,
    List<String> listRightAnswer,
    int partID,
    int start,
    {String? content,
    String? audioURL,
    List<String>? imagesURL,
    int examID = 0,
    bool isPremium = false}) async {
  List<int> listAnswersID = [];

  for (int i = 0; i < listAnswers.length; i++) {
    int id = start + i + 1;
    await addAnswer(id, listAnswers[i]);
    listAnswersID.add(id);
  }

  await FirebaseFirestore.instance
      .collection('Questions')
      .doc(id.toString())
      .set({
        'content': content,
        'list_question': listQuestion,
        'list_answers_id': listAnswersID,
        'list_right_answer': listRightAnswer,
        "audio": audioURL,
        "images": imagesURL,
        'part_id': partID,
        'is_premium': isPremium,
        'exam_id': examID
      })
      .then((value) => print("Question Added"))
      .catchError((error) => print("Failed to add question: $error"));
}
