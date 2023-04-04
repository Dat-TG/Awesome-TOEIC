import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toeic_app/utils/convert_dynamic.dart';
import 'package:toeic_app/utils/get_qa.dart';

Future<Map<String, dynamic>> statisticPraticeByUserID(String uid) async {
  List<double> progress = [for (int i = 0; i < 7; i++) 0];
  List<int> doneQuestionsForPart = [for (int i = 0; i < 7; i++) 0],
      correctQuestions = [for (int i = 0; i < 7; i++) 0];
  Map<String, dynamic> listHistory = {};

  QuerySnapshot<Map<String, dynamic>> history = await FirebaseFirestore.instance
      .collection('DoneExercises')
      .where('uid', isEqualTo: uid)
      .get();
  QuerySnapshot<Map<String, dynamic>> totalQuestion =
      await FirebaseFirestore.instance.collection('Part').get();

  for (int i = 0; i < history.docs.length; i++) {
    DocumentSnapshot<Map<String, dynamic>> getDoc = await FirebaseFirestore
        .instance
        .collection('DoneExercises')
        .doc(history.docs[i].id)
        .get();
    listHistory[history.docs[i].id] = getDoc.data();

    Map<String, dynamic> data = history.docs[i].data();
    int correct = data['correct'];
    doneQuestionsForPart[data['part'] - 1] +=
        convertListDynamicToListString(data['list_questions_id']).length;
    correctQuestions[data['part'] - 1] += correct;
  }
  for (var history in listHistory.entries) {
    List<Map<String, dynamic>> questions = [];
    for (int j = 0;
        j <
            convertListDynamicToListString(history.value['list_questions_id'])
                .length;
        j++) {
      Map<String, dynamic> qa = await (getQuestionsAndAnswersByQID(
          history.value['list_questions_id'][j] as String));
      questions.add(qa);
    }
    dynamic oldData = listHistory[history.key];
    oldData['list_questions'] = questions;
  }

  for (int i = 0; i < 7; i++) {
    progress[i] +=
        doneQuestionsForPart[i] / totalQuestion.docs[i]['NumberOfQuestion'];
  }

  return {
    'listHistory': listHistory,
    'doneQuestion': doneQuestionsForPart,
    'correctQuestion': correctQuestions,
    'progress': progress,
  };
}
