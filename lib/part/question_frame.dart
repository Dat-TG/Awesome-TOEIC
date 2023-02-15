import "package:flutter/material.dart";
import "package:toeic_app/constants.dart";

class QuestionFrame extends StatefulWidget {
  final int number;
  final String question;
  final List<String> answers;

  const QuestionFrame({
    super.key,
    required this.number,
    required this.question,
    required this.answers,
  });

  @override
  State<QuestionFrame> createState() => _QuestionFrameState();
}

class _QuestionFrameState extends State<QuestionFrame> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2 < 370
                      ? 370
                      : MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    color: colorApp,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: colorBoxShadow,
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                            minHeight: 50,
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.4),
                        padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                        child: SingleChildScrollView(
                          child: Text(
                            '${widget.number}. ${widget.question}',
                            style: TextStyle(fontSize: 17, color: textColor),
                          ),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width / 2 < 370
                              ? 370
                              : MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                          ),
                          child: Container(
                            constraints:
                                BoxConstraints(minHeight: 50, maxHeight: 200),
                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (int i = 0; i < 4; i++)
                                      Text(
                                        '${answersOption[i]}. ${widget.answers[i]}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                  ]),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]);
  }
}
