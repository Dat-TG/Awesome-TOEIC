import 'package:flutter/material.dart';
import 'package:toeic_app/constants.dart';
import 'package:toeic_app/part/app_bar.dart';
import 'package:toeic_app/part/part_five.dart';
import 'package:toeic_app/part/part_four.dart';
import 'package:toeic_app/part/part_one.dart';
import 'package:toeic_app/part/part_seven.dart';
import 'package:toeic_app/part/part_six.dart';
import 'package:toeic_app/part/part_three.dart';
import 'package:toeic_app/part/part_two.dart';
import 'package:toeic_app/utils/convert_dynamic.dart';

class HistoryAnswer extends StatefulWidget {
  final List<String> listRightAnswers;
  final Map<int, String> listAnswers;
  final List<Map<String, dynamic>> listQuestions;
  final List<int> listCheckQuestions;
  final int status;
  const HistoryAnswer(
      {super.key,
      required this.listAnswers,
      required this.listQuestions,
      required this.listRightAnswers,
      required this.listCheckQuestions,
      required this.status});

  @override
  State<HistoryAnswer> createState() => HistoryAnswerState();
}

class HistoryAnswerState extends State<HistoryAnswer> {
  int number = 0; // 01 23 456 78910 1112
  List<int> listStartQuestionPartSeven = [0];

  @override
  Widget build(BuildContext context) {
    number = 0;

    for (int index = 0; index < widget.listQuestions.length; index++) {
      listStartQuestionPartSeven.add(
          listStartQuestionPartSeven[listStartQuestionPartSeven.length - 1] +
              convertListDynamicToListString(
                      widget.listQuestions[index]['list_question'])
                  .length);
    }
    return Column(children: [
      for (int i = 0; i < widget.listQuestions.length; i++)
        for (int j = 0;
            j <
                convertListDynamicToListString(
                        widget.listQuestions[i]['list_question'])
                    .length;
            j++, number++)
          InkWell(
            onTap: () => onTapQuestion(i, j, listStartQuestionPartSeven[i]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 110,
                  child: Row(
                    children: [
                      Icon(
                        widget.listAnswers[number] ==
                                widget.listRightAnswers[number]
                            ? Icons.check
                            : Icons.close,
                        color: widget.listAnswers[number] ==
                                widget.listRightAnswers[number]
                            ? green
                            : red,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text('Câu ${i + 1}',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                for (String option in answersOption)
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.listRightAnswers[number] != "" &&
                              option == widget.listRightAnswers[number]
                          ? green
                          : option == widget.listAnswers[number]
                              ? red
                              : white,
                      border: Border.all(color: black, width: 1.3),
                      boxShadow: [
                        BoxShadow(
                          color: colorBoxShadow,
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: Text(
                      option,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
              ],
            ),
          )
    ]);
  }

  void onTapQuestion(int i, int j, int startQuestionPartSeven) {
    final int part = widget.listQuestions[i]['part_id'];
    final Map<String, dynamic> listQuestions = widget.listQuestions[i];
    final List<String> images =
        convertListDynamicToListString(listQuestions['images']);
    final List<String> questions =
        convertListDynamicToListString(listQuestions['list_question']);
    final String audio = listQuestions['audio'] as String;
    final List<dynamic> listAnswers = widget.listQuestions[i]['list_answers'];

    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          List<String> ans =
              widget.listAnswers.entries.map((e) => e.value).toList();

          return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.9,
              minChildSize: 0.9,
              maxChildSize: 0.9,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Scaffold(
                  appBar: AppBarPractice(
                      numAnswers: '${i + 1}.${j + 1}',
                      ansTrans: [],
                      answers: []),
                  body: part == 1
                      ? PartOneFrame(
                          number: i,
                          getAnswer: (nume, val) {},
                          ans: ans,
                          rightAnswers: [widget.listRightAnswers[i]],
                          listNameImages: images,
                          audio: audio)
                      : part == 2
                          ? PartTwoFrame(
                              number: i + 1,
                              audioPath: audio,
                              getAnswer: (nume, val) {},
                              ans: ans,
                              rightAnswers: [widget.listRightAnswers[i]])
                          : part == 3
                              ? PartThreeFrame(
                                  number: [1, 2, 3],
                                  audioPath: audio,
                                  images: images,
                                  question: questions,
                                  answers: [
                                    for (int k = 0; k < listAnswers.length; k++)
                                      convertListDynamicToListString(
                                          listAnswers[k])
                                  ],
                                  getAnswer: (nume, val) {},
                                  ans: ans.sublist(i * 3, (i + 1) * 3),
                                  rightAnswers: widget.listRightAnswers
                                      .sublist(i * 3, (i + 1) * 3))
                              : part == 4
                                  ? PartFourFrame(
                                      number: [1, 2, 3],
                                      audioPath: audio,
                                      images: images,
                                      question: questions,
                                      answers: [
                                        for (int k = 0;
                                            k < listAnswers.length;
                                            k++)
                                          convertListDynamicToListString(
                                              listAnswers[k])
                                      ],
                                      getAnswer: (nume, val) {},
                                      ans: ans.sublist(i * 3, (i + 1) * 3),
                                      rightAnswers: widget.listRightAnswers
                                          .sublist(i * 3, (i + 1) * 3))
                                  : part == 5
                                      ? PartFiveFrame(
                                          number: 0,
                                          question: questions[0],
                                          answers: convertListDynamicToListString(listAnswers[0]),
                                          getAnswer: (nume, val) {},
                                          rightAnswers: [
                                              widget.listRightAnswers[i]
                                            ],
                                          ans: [
                                              ans[i]
                                            ])
                                      : part == 6
                                          ? PartSixFrame(
                                              number: [1, 2, 3, 4],
                                              paragraph:
                                                  listQuestions['content'],
                                              question: questions,
                                              answers: [
                                                for (int k = 0;
                                                    k < listAnswers.length;
                                                    k++)
                                                  convertListDynamicToListString(
                                                      listAnswers[k])
                                              ],
                                              getAnswer: (nume, val) {},
                                              ans: ans.sublist(
                                                  i * 4, (i + 1) * 4),
                                              rightAnswers: widget.listRightAnswers
                                                  .sublist(i * 4, (i + 1) * 4))
                                          : part == 7
                                              ? PartSevenFrame(
                                                  number: [
                                                    for (int n = 0;
                                                        n < questions.length;
                                                        n++)
                                                      n
                                                  ],
                                                  question: questions,
                                                  answers: [
                                                    for (int k = 0;
                                                        k < listAnswers.length;
                                                        k++)
                                                      convertListDynamicToListString(
                                                          listAnswers[k])
                                                  ],
                                                  listNameImages: images,
                                                  getAnswer: (nume, val) {},
                                                  rightAnswersSelect:
                                                      widget.listRightAnswers.sublist(
                                                          startQuestionPartSeven,
                                                          startQuestionPartSeven + questions.length),
                                                  ans: ans.sublist(startQuestionPartSeven, startQuestionPartSeven + questions.length))
                                              : SizedBox.shrink(),
                );
              });
        });
  }
}
