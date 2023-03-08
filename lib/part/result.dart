import 'package:flutter/material.dart';
import 'package:toeic_app/constants.dart';
import 'package:toeic_app/home_page.dart';
import 'package:toeic_app/part/review_answer.dart';

class Result extends StatefulWidget {
  final List<String> listAnswers, listRightAnswers;
  final int part;
  const Result(
      {super.key,
      required this.part,
      required this.listAnswers,
      required this.listRightAnswers});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  int total = 0, correct = 0;
  double progress = 1;

  @override
  void initState() {
    setState(() {
      total = widget.listAnswers.length;
    });
    for (int i = 0; i < widget.listAnswers.length; i++) {
      if (widget.listAnswers[i] == widget.listRightAnswers[i]) {
        setState(() {
          correct += 1;
        });
      }
    }
    progress = correct / total * 1.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragEnd: (details) {},
          child: Container(
            padding: EdgeInsets.all(4.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomePage(intialIndex: 0)),
                                (Route<dynamic> route) => false);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/cup.png',
                          width: 170,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        'Chúc mừng',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      'Bạn đã hoàn thành bài luyện tập',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        listDesc[widget.part],
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: orange),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      widget.part < 5 ? '(Nghe hiểu)' : '(Đọc hiểu)',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: orange),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 10),
                            child: Text(
                              'Kết quả: $correct/$total',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width > 730
                                ? 700
                                : MediaQuery.of(context).size.width - 38,
                            child: Container(
                                constraints: BoxConstraints(
                                    minHeight: 30, maxHeight: 120),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
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
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Tỷ lệ đúng',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                        Text(
                                          '${double.parse((progress * 100).toStringAsFixed(2))}%',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 15),
                                      child: SizedBox(
                                        height: 8,
                                        child: Expanded(
                                          flex: 1,
                                          child: LinearProgressIndicator(
                                            backgroundColor: colorApp3,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              progress < 0.5 ? red : colorApp,
                                            ),
                                            value: progress,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      progress < 0.5 ? 'Tiếp tục cố gắng' : '',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 40),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReviewAnswers(
                                          listAnswers: widget.listAnswers,
                                          listRightAnswers:
                                              widget.listRightAnswers)));
                            },
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                backgroundColor: colorApp),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                'Hiển thị đáp án',
                                style: TextStyle(fontSize: 18),
                              ),
                            )),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage(intialIndex: 0)),
                                  (Route<dynamic> route) => false);
                              // Navigator.pop(context);
                              // Navigator.push(
                              //     context,
                              //     );
                            },
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                backgroundColor: colorApp),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                'Quay lại',
                                style: TextStyle(fontSize: 18),
                              ),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
