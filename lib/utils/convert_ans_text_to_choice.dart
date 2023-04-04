import 'package:toeic_app/constants.dart';

List<String> convertAnsTextToChoice(List<Map<String, dynamic>> data) {
  List<String> rightAns = [];
  for (int i = 0; i < data.length; i++) {
    for (int j = 0; j < 4; j++) {
      if (data.elementAt(i)['list_right_answer'][0] ==
          data.elementAt(i)['list_answers'][0][j]) {
        if (j == 0) {
          rightAns.add("A");
        } else if (j == 1) {
          rightAns.add("B");
        } else if (j == 2) {
          rightAns.add("C");
        } else {
          rightAns.add("D");
        }
      }
    }
  }
  return rightAns;
}

List<String> convertListAnsTextToListChoice(List<Map<String, dynamic>> data) {
  List<String> rightAns = [];
  
  for (int i = 0; i < data.length; i++) {
    for (int k = 0; k < data.elementAt(i)['list_answers'].length; k++) {
      for (int j = 0; j < 4; j++) {
        if (answersOption.contains(data[i]['list_right_answer'][k])) {}
        if (data.elementAt(i)['list_right_answer'][k] ==
            data.elementAt(i)['list_answers'][k][j]) {
          if (j == 0) {
            rightAns.add("A");
          } else if (j == 1) {
            rightAns.add("B");
          } else if (j == 2) {
            rightAns.add("C");
          } else {
            rightAns.add("D");
          }
        }
      }
    }
  }
  return rightAns;
}
