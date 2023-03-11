import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toeic_app/part/part_one.dart';

import '../constants.dart';
import '../part/part_two.dart';
import 'app_bar.dart';

class Testing extends StatefulWidget {
  final String testID;
  final List<DocumentSnapshot<Map<String, dynamic>>>? data;
  const Testing({super.key, required this.testID, required this.data});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  List<String> numAnswers = [];
  List<List<Map<String, dynamic>>> listQuestion = [[], [], [], [], [], [], []];
  int _curr = 0;
  int _number = 0;
  List<String> _answer = [];
  bool isShow = false;
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.data!.length; i++) {
      int j = widget.data![i]['part_id'];
      listQuestion[j - 1].add(widget.data![i].data() as Map<String, dynamic>);
    }
    int temp = 1;
    for (int i = 0; i < 7; i++) {
      numAnswers.add("");
      for (int j = 0; j < listQuestion[i].length; j++) {
        numAnswers.add(temp.toString());
        temp++;
      }
    }
    print(numAnswers);
    for (int i = 0; i < 200; i++) {
      _answer.add("");
    }
  }

  void callbackAnswer(int number, String ans) {
    setState(() {
      if (_answer[number] == "") _answer[number] = ans;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
      appBar: AppBarTesting(
        numAnswers: numAnswers[_curr],
      ),
      body: PageView(
        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        controller: controller,
        children: [
          PartIntro(part: 1),
          for (int i = 0; i < listQuestion[0].length; i++)
            PartOneFrame(
                number: i,
                getAnswer: (numb, value) => callbackAnswer(numb, value),
                ans: _answer,
                rightAnswers: convertListDynamicToListString(
                    listQuestion[0][i]['list_right_answer']),
                listNameImages: convertListDynamicToListString(
                    listQuestion[0][i]['images']),
                audio: listQuestion[0][i]['audio'],
                isShow: isShow,
                cancelShowExplan: (s) {
                  setState(() {
                    isShow = s;
                  });
                }),
          PartIntro(part: 2),
          for (int i = listQuestion[0].length;
              i < listQuestion[0].length + listQuestion[1].length;
              i++)
            PartTwoFrame(
              audioPath: listQuestion[1][i - listQuestion[0].length]['audio'],
              number: i + 1,
              getAnswer: (numb, value) => callbackAnswer(numb - 1, value),
              ans: _answer,
              rightAnswers: convertListDynamicToListString(listQuestion[1]
                  [i - listQuestion[0].length]['list_right_answer']),
            ),
          PartIntro(part: 3),
          PartIntro(part: 4),
          PartIntro(part: 5),
          PartIntro(part: 6),
          PartIntro(part: 7),
        ],
        onPageChanged: (value) {
          setState(() {
            _curr = value;
          });
          printError('page $_curr');
          printError(numAnswers[_curr]);
          printError(_number.toString());
        },
      ),
    );
  }
}

class PartIntro extends StatelessWidget {
  final int part;
  const PartIntro({super.key, required this.part});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          if (part == 1)
            Text(
              "PART 1: PHOTOGRAPHS",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          else if (part == 2)
            Text(
              "PART 2: QUESTION-RESPONSE",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          else if (part == 3)
            Text(
              "PART 3: CONVERSATIONS",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          else if (part == 4)
            Text(
              "PART 4: SHORT TALKS",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          else if (part == 5)
            Text(
              "PART 5: INCOMPLETE SENTENCES",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          else if (part == 6)
            Text(
              "PART 6: TEXT COMPLETION",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          else if (part == 7)
            Text(
              "PART 7: READING COMPREHENSION",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          Text(listDirectionEng[part - 1])
        ],
      ),
    );
  }
}
