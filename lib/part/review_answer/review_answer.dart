import 'package:flutter/material.dart';
import 'package:toeic_app/constants.dart';
import 'package:toeic_app/utils/convert_dynamic.dart';
import './history_answer.dart';

class ReviewAnswers extends StatefulWidget {
  final List<String> listAnswers, listRightAnswers;
  final List<Map<String, dynamic>> listQuestions;
  const ReviewAnswers(
      {super.key,
      required this.listAnswers,
      required this.listQuestions,
      required this.listRightAnswers});

  @override
  State<ReviewAnswers> createState() => _ReviewAnswersState();
}

class _ReviewAnswersState extends State<ReviewAnswers> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Map<int, String> listCorrectAnswers = {};
  Map<int, String> listWrongAnswers = {};
  Map<int, String> listAllAnswers = {};
  List<int> listCheckQuestions =
      []; // -1: true = 0 , 0: false, true > 0, 1: false = 0
  int number = 0;

  @override
  void initState() {
    for (int i = 0; i < widget.listQuestions.length; i++) {
      bool flag1 = false, flag2 = true;
      for (int j = 0;
          j <
              convertListDynamicToListString(
                      widget.listQuestions[i]['list_question'])
                  .length;
          j++, number++) {
        listAllAnswers[number] = widget.listAnswers[number];

        if (widget.listAnswers[number] != widget.listRightAnswers[number]) {
          flag2 = false;
          listWrongAnswers[number] = widget.listAnswers[number];
        } else {
          flag1 = true;
          listCorrectAnswers[number] = widget.listAnswers[number];
        }
      }
      if (flag1 == flag2) {
        if (flag1 == true) {
          listCheckQuestions.add(1);
        } else {
          listCheckQuestions.add(-1);
        }
      } else {
        listCheckQuestions.add(0);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.listAnswers);
    print(widget.listQuestions);
    print(widget.listRightAnswers);
    return Scaffold(
        appBar: AppBar(
          title: Text('Hiển thị đáp án'),
          centerTitle: true,
          backgroundColor: colorApp,
        ),
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              Row(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width > 730
                            ? 700
                            : MediaQuery.of(context).size.width - 30,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: colorBox,
                              boxShadow: [
                                BoxShadow(
                                  color: colorBoxShadow,
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: _currentPage == 0
                                              ? colorApp.withOpacity(0.7)
                                              : colorApp.withOpacity(0.2),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _currentPage = 0;
                                            _pageController
                                                .jumpToPage(_currentPage);
                                          });
                                        },
                                        child: Text(
                                          'Tất cả',
                                          style: TextStyle(
                                              color: black, fontSize: 15),
                                        )),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, right: 4),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: _currentPage == 1
                                                ? colorApp.withOpacity(0.7)
                                                : colorApp.withOpacity(0.2),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _currentPage = 1;
                                              _pageController
                                                  .jumpToPage(_currentPage);
                                            });
                                          },
                                          child: Text(
                                            'Chọn đúng',
                                            style: TextStyle(
                                                color: black, fontSize: 15),
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: _currentPage == 2
                                              ? colorApp.withOpacity(0.7)
                                              : colorApp.withOpacity(0.2),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _currentPage = 2;
                                            _pageController
                                                .jumpToPage(_currentPage);
                                          });
                                        },
                                        child: Text(
                                          'Chọn sai',
                                          style: TextStyle(
                                              color: black, fontSize: 15),
                                        )),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width > 730
                    ? 700
                    : MediaQuery.of(context).size.width - 30,
                height: MediaQuery.of(context).size.height * 0.7,
                child: PageView(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (number) {
                    setState(() {
                      _currentPage = number;
                    });
                  },
                  children: [
                    SingleChildScrollView(
                      child: HistoryAnswer(
                          status: 0,
                          listCheckQuestions: listCheckQuestions,
                          listQuestions: widget.listQuestions,
                          listAnswers: listAllAnswers,
                          listRightAnswers: widget.listRightAnswers),
                    ),
                    SingleChildScrollView(
                      child: HistoryAnswer(
                          status: 1,
                          listCheckQuestions: listCheckQuestions,
                          listQuestions: widget.listQuestions,
                          listAnswers: listCorrectAnswers,
                          listRightAnswers: widget.listRightAnswers),
                    ),
                    SingleChildScrollView(
                      child: HistoryAnswer(
                          status: -1,
                          listCheckQuestions: listCheckQuestions,
                          listQuestions: widget.listQuestions,
                          listAnswers: listWrongAnswers,
                          listRightAnswers: widget.listRightAnswers),
                    )
                  ],
                ),
              )
            ])));
  }
}


