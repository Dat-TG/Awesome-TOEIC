import 'package:flutter/material.dart';
import 'package:toeic_app/constants.dart';

class ReviewAnswers extends StatefulWidget {
  final List<String> listAnswers, listRightAnswers;
  const ReviewAnswers(
      {super.key, required this.listAnswers, required this.listRightAnswers});

  @override
  State<ReviewAnswers> createState() => _ReviewAnswersState();
}

class _ReviewAnswersState extends State<ReviewAnswers> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Map<int, String> listCorrectAnswers = {};
  Map<int, String> listWrongAnswers = {};
  Map<int, String> listAllAnswers = {};

  @override
  void initState() {
    for (int i = 0; i < widget.listAnswers.length; i++) {
      listAllAnswers[i] = widget.listAnswers[i];
      if (widget.listAnswers[i] == widget.listRightAnswers[i]) {
        listCorrectAnswers[i] = widget.listAnswers[i];
      } else {
        listWrongAnswers[i] = widget.listAnswers[i];
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          listAnswers: listAllAnswers,
                          listRightAnswers: widget.listRightAnswers),
                    ),
                    SingleChildScrollView(
                      child: HistoryAnswer(
                          listAnswers: listCorrectAnswers,
                          listRightAnswers: widget.listRightAnswers),
                    ),
                    SingleChildScrollView(
                      child: HistoryAnswer(
                          listAnswers: listWrongAnswers,
                          listRightAnswers: widget.listRightAnswers),
                    )
                  ],
                ),
              )
            ])));
  }
}

class HistoryAnswer extends StatefulWidget {
  final List<String> listRightAnswers;
  final Map<int, String> listAnswers;
  const HistoryAnswer(
      {super.key, required this.listAnswers, required this.listRightAnswers});

  @override
  State<HistoryAnswer> createState() => HistoryAnswerState();
}

class HistoryAnswerState extends State<HistoryAnswer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.listAnswers.entries
          .map((ans) => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 110,
                    child: Row(
                      children: [
                        Icon(
                          ans.value == widget.listRightAnswers[ans.key]
                              ? Icons.check
                              : Icons.close,
                          color: widget.listAnswers[ans.key] ==
                                  widget.listRightAnswers[ans.key]
                              ? green
                              : red,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Text('Câu ${ans.key + 1}',
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
                        color: widget.listRightAnswers[ans.key] != "" &&
                                option == widget.listRightAnswers[ans.key]
                            ? green
                            : option == widget.listAnswers[ans.key]
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
              ))
          .toList(),
    );
  }
}
