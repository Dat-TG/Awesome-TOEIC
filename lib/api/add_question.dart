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




// Future<void> updateData() async {
//   for (int i = 132; i <= 154; i++) {
//     await updateListRightAnswer(i, listRightAnswer[i - 101]);
//   }
// }

// Import data
// Future<void> importData() async {
//   var documents = await firestore.collection("Answers").get();
//   setState(() {
//     start = documents.size;
//   });
//   for (int i = 0; i < 6; i++) {
//     await addQuestion(qID[i], listQuestion[i], listAnswers[i],
//         listRightAnswer[i], partID[i], start,
//         imagesURL: [imagesURL[0][i]], audioURL: audio[i], examID: examID);
//     documents = await firestore.collection("Answers").get();
//     setState(() {
//       start = documents.size;
//     });
//   }

//   for (int i = 6; i < 31; i++) {
//     await addQuestion(qID[i], listQuestion[i], listAnswers[i],
//         listRightAnswer[i], partID[i], start,
//         audioURL: audio[i], examID: examID);
//     documents = await firestore.collection("Answers").get();
//     setState(() {
//       start = documents.size;
//     });
//   }

//   for (int i = 31; i < 54; i++) {
//     await addQuestion(qID[i], listQuestion[i], listAnswers[i],
//         listRightAnswer[i], partID[i], start,
//         audioURL: audio[i], examID: examID, imagesURL: [imagesURL[1][i - 31]]);
//     documents = await firestore.collection("Answers").get();
//     setState(() {
//       start = documents.size;
//     });
//   }
// }
