import 'package:flutter/material.dart';
import 'package:toeic_app/constants.dart';
import 'package:toeic_app/part/app_bar.dart';
import 'package:toeic_app/part/part_five.dart';
import 'package:toeic_app/part/part_four.dart';
import 'package:toeic_app/part/part_one.dart';
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
  int number = 0;
  @override
  Widget build(BuildContext context) {
    number = 0;
    return Column(children: [
      for (int i = 0; i < widget.listQuestions.length; i++)
        for (int j = 0;
            j <
                convertListDynamicToListString(
                        widget.listQuestions[i]['list_question'])
                    .length;
            j++, number++)
          InkWell(
            onTap: () => onTapQuestion(i, j),
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

  void onTapQuestion(int i, int j) {
    int part = widget.listQuestions[i]['part_id'];
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
                          listNameImages: convertListDynamicToListString(
                              widget.listQuestions[i]['images']),
                          audio: widget.listQuestions[i]['audio'] as String)
                      : part == 2
                          ? PartTwoFrame(
                              number: i + 1,
                              audioPath:
                                  widget.listQuestions[i]['audio'] as String,
                              getAnswer: (nume, val) {},
                              ans: ans,
                              rightAnswers: [widget.listRightAnswers[i]])
                          : part == 3
                              ? PartThreeFrame(
                                  number: [1, 2, 3],
                                  audioPath: widget.listQuestions[i]['audio']
                                      as String,
                                  images: convertListDynamicToListString(
                                      widget.listQuestions[i]['images']),
                                  question: convertListDynamicToListString(
                                      widget.listQuestions[i]['list_question']),
                                  answers: [
                                    for (int k = 0;
                                        k <
                                            widget
                                                .listQuestions[i]
                                                    ['list_answers']
                                                .length;
                                        k++)
                                      convertListDynamicToListString(widget
                                          .listQuestions[i]['list_answers'][k])
                                  ],
                                  getAnswer: (nume, val) {},
                                  ans: ans.sublist(i * 3, (i + 1) * 3),
                                  rightAnswers: widget.listRightAnswers
                                      .sublist(i * 3, (i + 1) * 3))
                              : part == 4
                                  ? PartFourFrame(
                                      number: [1, 2, 3],
                                      audioPath: widget.listQuestions[i]
                                          ['audio'] as String,
                                      images:
                                          convertListDynamicToListString(widget.listQuestions[i]['images']),
                                      question: convertListDynamicToListString(widget.listQuestions[i]['list_question']),
                                      answers: [
                                        for (int k = 0;
                                            k <
                                                widget
                                                    .listQuestions[i]
                                                        ['list_answers']
                                                    .length;
                                            k++)
                                          convertListDynamicToListString(
                                              widget.listQuestions[i]
                                                  ['list_answers'][k])
                                      ],
                                      getAnswer: (nume, val) {},
                                      ans: ans.sublist(i * 3, (i + 1) * 3),
                                      rightAnswers: widget.listRightAnswers.sublist(i * 3, (i + 1) * 3))
                                  : part == 5
                                      ? PartFiveFrame(number: 0, question: widget.listQuestions[i]['list_question'][0] as String, answers: convertListDynamicToListString(widget.listQuestions[i]['list_answers'][0]), getAnswer: (nume, val) {}, rightAnswers: [widget.listRightAnswers[i]], ans: [ans[i]])
                                      : part == 6
                                          ? PartSixFrame(
                                              number: [1, 2, 3, 4],
                                              paragraph: widget.listQuestions[i]['content'],
                                              question: convertListDynamicToListString(widget.listQuestions[i]['list_question']),
                                              answers: [
                                                for (int k = 0;
                                                    k <
                                                        widget
                                                            .listQuestions[i]
                                                                ['list_answers']
                                                            .length;
                                                    k++)
                                                  convertListDynamicToListString(
                                                      widget.listQuestions[i]
                                                          ['list_answers'][k])
                                              ],
                                              getAnswer: (nume, val) {},
                                              ans: ans.sublist(i * 4, (i + 1) * 4),
                                              rightAnswers: widget.listRightAnswers.sublist(i * 4, (i + 1) * 4))
                                          : part == 7
                                              ? PartSixFrame(
                                                  number: [1, 2, 3, 4],
                                                  paragraph: widget.listQuestions[i]['content'],
                                                  question: convertListDynamicToListString(widget.listQuestions[i]['list_question']),
                                                  answers: [
                                                    for (int k = 0;
                                                        k <
                                                            widget
                                                                .listQuestions[
                                                                    i][
                                                                    'list_answers']
                                                                .length;
                                                        k++)
                                                      convertListDynamicToListString(
                                                          widget.listQuestions[
                                                                  i][
                                                              'list_answers'][k])
                                                  ],
                                                  getAnswer: (nume, val) {},
                                                  ans: ans.sublist(i * 3, (i + 1) * 3),
                                                  rightAnswers: widget.listRightAnswers.sublist(i * 2, (i + 1) * 2))
                                              : SizedBox.shrink(),
                );
              });
        });
  }
}
