import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toeic_app/utils/convert_dynamic.dart';

Future<Map<String, dynamic>> statisticPraticeByUserID(String uid) async {
  List<double> progress = [for (int i = 0; i < 7; i++) 0];
  List<int> doneQuestionsForPart = [for (int i = 0; i < 7; i++) 0],
      correctQuestions = [for (int i = 0; i < 7; i++) 0];

  QuerySnapshot<Map<String, dynamic>> history = await FirebaseFirestore.instance
      .collection('DoneExercises')
      .where('uid', isEqualTo: uid)
      .get();
  QuerySnapshot<Map<String, dynamic>> totalQuestion =
      await FirebaseFirestore.instance.collection('Part').get();

  for (int i = 0; i < history.docs.length; i++) {
    Map<String, dynamic> data = history.docs[i].data();
    int correct = data['correct'];
    doneQuestionsForPart[data['part'] - 1] +=
        convertListDynamicToListString(data['list_questions_id']).length;
    correctQuestions[data['part'] - 1] += correct;
  }
  for (int i = 0; i < history.docs.length; i++) {
    progress[i] +=
        doneQuestionsForPart[i] / totalQuestion.docs[i]['NumberOfQuestion'];
  }
  
  return {
    'doneQuestion': doneQuestionsForPart,
    'correctQuestion': correctQuestions,
    'progress': progress
  };
}
