import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toeic_app/part/part_one.dart';

import '../constants.dart';
import '../part/part_five.dart';
import '../part/part_four.dart';
import '../part/part_seven.dart';
import '../part/part_six.dart';
import '../part/part_three.dart';
import '../part/part_two.dart';
import '../utils/convert_dynamic.dart';
import 'app_bar.dart';

class Testing extends StatefulWidget {
  final String testID;
  final List<Map<String, dynamic>>? data;
  const Testing({super.key, required this.testID, required this.data});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  List<String> numAnswers = [];
  List<List<Map<String, dynamic>>> listQuestion = [[], [], [], [], [], [], []];
  int _curr = 0;
  int _number = 0;
  List<String> _answer = [], rightAnswerSelect = [];
  bool isShow = false;
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.data!.length; i++) {
      int j = widget.data![i]['part_id'];
      listQuestion[j - 1].add(widget.data![i]);
    }
    int temp = 1;
    for (int i = 0; i < 7; i++) {
      numAnswers.add("");
      for (int j = 0; j < listQuestion[i].length; j++) {
        if (i < 2 || i == 4) {
          numAnswers.add(temp.toString());
          temp++;
        } else {
          numAnswers.add(
              "$temp - ${temp += convertListDynamicToListString(listQuestion[i][j]['list_question']).length - 1}");
          temp++;
        }
      }
    }
    for (int i = 0; i < 200; i++) {
      _answer.add("");
    }
    for (int i = 0; i < listQuestion[0].length; i++) {
      rightAnswerSelect.add(listQuestion[0][i]['list_right_answer'][0]);
    }
    for (int i = 0; i < listQuestion[1].length; i++) {
      rightAnswerSelect.add(listQuestion[1][i]['list_right_answer'][0]);
    }
    for (int i = 1; i <= 7; i++) {
      rightAnswerSelect.addAll(compareAnswersToRightAnswers(i));
    }
    print(rightAnswerSelect);
  }

  void callbackAnswer(int number, String ans) {
    setState(() {
      if (_answer[number] == "") _answer[number] = ans;
    });
  }

  List<String> compareAnswersToRightAnswers(int part) {
    List<String> rightAns = [];
    for (int i = 0; i < listQuestion[part - 1].length; i++) {
      for (int k = 0;
          k < listQuestion[part - 1].elementAt(i)['list_answers'].length;
          k++) {
        for (int j = 0; j < 4; j++) {
          if (answersOption
              .contains(listQuestion[part - 1][i]['list_right_answer'][k])) {}
          if (listQuestion[part - 1].elementAt(i)['list_right_answer'][k] ==
              listQuestion[part - 1].elementAt(i)['list_answers'][k][j]) {
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

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    int startPart3 = 32;
    int startPart4 = 71;
    int startPart6 = 131;
    int startPart5 = 100;
    int startPart7 = 146;
    return Scaffold(
      appBar: AppBarTesting(
        numAnswers: numAnswers[_curr],
        answer: rightAnswerSelect,
        answerSelect: _answer,
        pageController: controller,
        testID: widget.testID,
        data: widget.data,
      ),
      body: PageView(
        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        controller: controller,
        children: [
          PartIntro(part: 1, controller: controller),
          for (int i = 0; i < listQuestion[0].length; i++)
            PartOneFrame(
              number: i,
              getAnswer: (numb, value) => callbackAnswer(numb, value),
              ans: _answer,
              rightAnswers: convertListDynamicToListString(
                  listQuestion[0][i]['list_right_answer']),
              listNameImages:
                  convertListDynamicToListString(listQuestion[0][i]['images']),
              audio: listQuestion[0][i]['audio'],
              isExam: true,
            ),
          PartIntro(
            part: 2,
            controller: controller,
          ),
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
              isExam: true,
            ),
          PartIntro(
            part: 3,
            controller: controller,
          ),
          for (int i = listQuestion[0].length + listQuestion[1].length;
              i <
                  listQuestion[0].length +
                      listQuestion[1].length +
                      listQuestion[2].length;
              i++)
            PartThreeFrame(
              number: [
                for (int j = 0;
                    j <
                        convertListDynamicToListListString(listQuestion[2][i -
                                listQuestion[0].length -
                                listQuestion[1].length]['list_answers'])
                            .length;
                    j++)
                  startPart3++
              ],
              audioPath: listQuestion[2]
                      [i - listQuestion[0].length - listQuestion[1].length]
                  ['audio'],
              images: List<String>.from(listQuestion[2]
                      [i - listQuestion[0].length - listQuestion[1].length]
                  ['images'] as List),
              question: List<String>.from(listQuestion[2]
                      [i - listQuestion[0].length - listQuestion[1].length]
                  ['list_question'] as List),
              answers: convertListDynamicToListListString(listQuestion[2]
                      [i - listQuestion[0].length - listQuestion[1].length]
                  ['list_answers']),
              getAnswer: (number, value) => callbackAnswer(number - 1, value),
              ans: _answer,
              rightAnswers: rightAnswerSelect,
              isExam: true,
            ),
          PartIntro(
            part: 4,
            controller: controller,
          ),
          for (int i = listQuestion[0].length +
                  listQuestion[1].length +
                  listQuestion[2].length;
              i <
                  listQuestion[0].length +
                      listQuestion[1].length +
                      listQuestion[2].length +
                      listQuestion[3].length;
              i++)
            PartFourFrame(
              number: [
                for (int j = 0;
                    j <
                        convertListDynamicToListListString(listQuestion[3][i -
                                listQuestion[0].length -
                                listQuestion[1].length -
                                listQuestion[2].length]['list_answers'])
                            .length;
                    j++)
                  startPart4++
              ],
              audioPath: listQuestion[3][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length]['audio'],
              images: List<String>.from(listQuestion[3][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length]['images'] as List),
              question: List<String>.from(listQuestion[3][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length]['list_question'] as List),
              answers: convertListDynamicToListListString(listQuestion[3][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length]['list_answers']),
              getAnswer: (number, value) => callbackAnswer(number - 1, value),
              ans: _answer,
              rightAnswers: rightAnswerSelect,
              isExam: true,
            ),
          PartIntro(
            part: 5,
            controller: controller,
          ),
          for (int i = listQuestion[0].length +
                  listQuestion[1].length +
                  listQuestion[2].length +
                  listQuestion[3].length;
              i <
                  listQuestion[0].length +
                      listQuestion[1].length +
                      listQuestion[2].length +
                      listQuestion[3].length +
                      listQuestion[4].length;
              i++)
            PartFiveFrame(
              number: startPart5++,
              question: listQuestion[4][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length -
                  listQuestion[3].length]['list_question'][0],
              answers: convertListDynamicToListString(listQuestion[4].elementAt(
                  i -
                      listQuestion[0].length -
                      listQuestion[1].length -
                      listQuestion[2].length -
                      listQuestion[3].length)['list_answers'][0]),
              getAnswer: (number, value) => callbackAnswer(number, value),
              ans: _answer,
              rightAnswers: rightAnswerSelect,
              isExam: true,
            ),
          PartIntro(
            part: 6,
            controller: controller,
          ),
          for (int i = listQuestion[0].length +
                  listQuestion[1].length +
                  listQuestion[2].length +
                  listQuestion[3].length +
                  listQuestion[4].length;
              i <
                  listQuestion[0].length +
                      listQuestion[1].length +
                      listQuestion[2].length +
                      listQuestion[3].length +
                      listQuestion[4].length +
                      listQuestion[5].length;
              i++)
            PartSixFrame(
              number: [
                for (int j = 0;
                    j <
                        convertListDynamicToListListString(listQuestion[5][i -
                                listQuestion[0].length -
                                listQuestion[1].length -
                                listQuestion[2].length -
                                listQuestion[3].length -
                                listQuestion[4].length]['list_answers'])
                            .length;
                    j++)
                  startPart6++
              ],
              paragraph: listQuestion[5][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length -
                  listQuestion[3].length -
                  listQuestion[4].length]['content'],
              question: List<String>.from(listQuestion[5][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length -
                  listQuestion[3].length -
                  listQuestion[4].length]['list_question'] as List),
              answers: convertListDynamicToListListString(listQuestion[5][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length -
                  listQuestion[3].length -
                  listQuestion[4].length]['list_answers']),
              getAnswer: (number, value) => callbackAnswer(number - 1, value),
              ans: _answer,
              rightAnswers: rightAnswerSelect,
              isExam: true,
            ),
          PartIntro(
            part: 7,
            controller: controller,
          ),
          for (int i = listQuestion[0].length +
                  listQuestion[1].length +
                  listQuestion[2].length +
                  listQuestion[3].length +
                  listQuestion[4].length +
                  listQuestion[5].length;
              i <
                  listQuestion[0].length +
                      listQuestion[1].length +
                      listQuestion[2].length +
                      listQuestion[3].length +
                      listQuestion[4].length +
                      listQuestion[5].length +
                      listQuestion[6].length;
              i++)
            PartSevenFrame(
              number: [
                for (int j = 0;
                    j <
                        convertListDynamicToListListString(listQuestion[6][i -
                                listQuestion[0].length -
                                listQuestion[1].length -
                                listQuestion[2].length -
                                listQuestion[3].length -
                                listQuestion[4].length -
                                listQuestion[5].length]['list_answers'])
                            .length;
                    j++)
                  startPart7++
              ],
              question: convertListDynamicToListString(listQuestion[6][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length -
                  listQuestion[3].length -
                  listQuestion[4].length -
                  listQuestion[5].length]['list_question']),
              answers: convertListDynamicToListListString(listQuestion[6][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length -
                  listQuestion[3].length -
                  listQuestion[4].length -
                  listQuestion[5].length]['list_answers']),
              rightAnswersSelect: rightAnswerSelect,
              getAnswer: (number, value) => callbackAnswer(number, value),
              ans: _answer,
              listNameImages: convertListDynamicToListString(listQuestion[6][i -
                  listQuestion[0].length -
                  listQuestion[1].length -
                  listQuestion[2].length -
                  listQuestion[3].length -
                  listQuestion[4].length -
                  listQuestion[5].length]['images']),
              isExam: true,
            ),
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
  final PageController controller;
  const PartIntro({super.key, required this.part, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
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
            SizedBox(
              height: 10,
            ),
            Text(
              listDirectionEng[part - 1],
              textAlign: TextAlign.start,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeInOut);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(colorApp),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "Bắt đầu",
                        style: TextStyle(color: white),
                      ),
                    ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
