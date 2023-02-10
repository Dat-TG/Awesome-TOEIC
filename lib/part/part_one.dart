import 'package:flutter/material.dart';

import './../constants.dart';

class PartOne extends StatefulWidget {
  const PartOne({super.key});

  @override
  State<PartOne> createState() => _PartOneState();
}

class _PartOneState extends State<PartOne> {
  String _dropDownValue = "10";
  bool _isTest = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Đoạn văn đơn"),
          backgroundColor: colorApp,
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 252, 251, 251),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        )
                      ],
                    ),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 12, 25, 12),
                        child: Image.asset(
                          'assets/img/image_icon.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text(
                              'Số câu đã làm',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '0',
                              style: TextStyle(fontSize: 16),
                            ),
                          ]),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Row(
                              children: [
                                Text(
                                  'Trả lời đúng',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '0',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Hoàn thành',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 120,
                                height: 6,
                                child: LinearProgressIndicator(
                                  backgroundColor: colorApp3,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    colorApp,
                                  ),
                                  value: 0.1,
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 252, 251, 251),
                        border: Border.symmetric(),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          )
                        ],
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Câu hỏi',
                              style: TextStyle(
                                  fontSize: 21,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text(
                                  'For each question in this part, you will hear four statements about a picture in your test book. When you hear the statements, you must select the one statement that best describes what you see in the picture. Then find the number of the question on your answer sheet and mark your answer. The statements will not be printed in your test book and will be spoken only one time.'),
                            ),
                            Text(
                              'Với mỗi câu hỏi, bạn sẽ được xem một bức tranh',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontStyle: FontStyle.italic),
                            )
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                  text: "Nâng cấp",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline)),
                              TextSpan(
                                  text:
                                      ' để tải toàn bộ bài tập về máy, tải dữ liệu nhanh hơn, ổn định hơn')
                            ])),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Số câu hỏi: ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 252, 251, 251),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      )
                                    ],
                                  ),
                                  child: DropdownButton(
                                    hint: _dropDownValue == null
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 10,
                                            ),
                                            child: Text("abs"),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 10,
                                            ),
                                            child: Text(_dropDownValue),
                                          ),
                                    items: ['10', '20', '30']
                                        .map((val) => DropdownMenuItem<String>(
                                            value: val, child: Text(val)))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _dropDownValue = value!;
                                      });
                                    },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 16),
                                  ),
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Kiểm tra: ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Switch(
                              value: _isTest,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _isTest = newValue;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 20),
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              backgroundColor: colorApp),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                            child: Text(
                              'Bắt đầu nào',
                              style: TextStyle(fontSize: 17),
                            ),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
