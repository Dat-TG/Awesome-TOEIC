import 'package:cloud_firestore/cloud_firestore.dart';


Future<List<Map<String, dynamic>>> getQuestionsAndAnswers(
    int partID) async {
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
