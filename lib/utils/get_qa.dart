import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> getQuestionsAndAnswers(int partID) async {
  List<Map<String, dynamic>> data = [];
  Map<String, dynamic> temp;
  await FirebaseFirestore.instance
      .collection("Questions")
      .where('part_id', isEqualTo: partID)
      .get()
      .then((value) async => {
            for (int i = 0; i < value.docs.length; i++)
              {
                temp = value.docs[i].data(),
                temp['id'] = value.docs[i].id,
                temp['list_answers'] = [],
                data.add(temp),
                for (int j = 0; j < temp['list_answers_id'].length; j++)
                  {
                    await FirebaseFirestore.instance
                        .collection("Answers")
                        .where(FieldPath.documentId,
                            isEqualTo: temp['list_answers_id'][j].toString())
                        .get()
                        .then((value) => {
                              temp['list_answers']
                                  .add(value.docs[0].data()['list_answers']),
                              //print("answer ${temp['list_answers'][j]}")
                            })
                  }
              },
            print(value.docs.length)
          });
  return data;
}

Future<List<Map<String, dynamic>>> getQuestionsAndAnswersByQID(
    String id) async {
  List<Map<String, dynamic>> data = [];
  dynamic temp;

  await FirebaseFirestore.instance.collection("Questions").doc(id).get().then(
        (value) async => {
          temp = value.data(),
          temp['id'] = value.id,
          temp['list_answers'] = [],
          data.add(temp),
          for (int j = 0; j < temp['list_answers_id'].length; j++)
            {
              await FirebaseFirestore.instance
                  .collection("Answers")
                  .where(FieldPath.documentId,
                      isEqualTo: temp['list_answers_id'][j].toString())
                  .get()
                  .then((value) => {
                        temp['list_answers']
                            .add(value.docs[0].data()['list_answers']),
                      })
            }
        },
      );
  return data;
}

Future<List<Map<String, dynamic>>> getQuestionsAndAnswersFilterByUserID(
    String uid, int partID) async {
  List<Map<String, dynamic>> data = [];
  List<String> listQuestionsDone = [];
  Map<String, dynamic> temp;

  // Get all question ID that user make them done
  QuerySnapshot<Map<String, dynamic>> listDoneEx = await FirebaseFirestore
      .instance
      .collection('DoneExercises')
      .where('uid', isEqualTo: uid)
      .where('part', isEqualTo: partID)
      .get();
  for (int i = 0; i < listDoneEx.docs.length; i++) {
    temp = listDoneEx.docs[i].data();
    for (int j = 0; j < temp['list_questions_id'].length; j++) {
      listQuestionsDone.add(temp['list_questions_id'][j] as String);
    }
  }

  // return data exception question above
  await FirebaseFirestore.instance
      .collection("Questions")
      .where('part_id', isEqualTo: partID)
      .get()
      .then((value) async => {
            for (int i = 0; i < value.docs.length; i++)
              {
                if (!listQuestionsDone.contains(value.docs[i].id))
                  {
                    temp = value.docs[i].data(),
                    temp['id'] = value.docs[i].id,
                    temp['list_answers'] = [],
                    data.add(temp),
                    for (int j = 0; j < temp['list_answers_id'].length; j++)
                      {
                        await FirebaseFirestore.instance
                            .collection("Answers")
                            .where(FieldPath.documentId,
                                isEqualTo:
                                    temp['list_answers_id'][j].toString())
                            .get()
                            .then((value) => {
                                  temp['list_answers'].add(
                                      value.docs[0].data()['list_answers']),
                                })
                      }
                  }
              },
          });
  return data;
}
