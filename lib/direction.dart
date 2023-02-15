import 'package:flutter/material.dart';

import 'constants.dart';

class Direction extends StatefulWidget {
  final int part;

  // Constructor
  const Direction({super.key, required this.part});

  @override
  State<Direction> createState() => _DirectionState();
}

class _DirectionState extends State<Direction> {
  String _dropDownValue = "10"; // Set default value: 10
  bool _isTest = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${listTitle[widget.part]} - ${listDesc[widget.part]}"),
          backgroundColor: colorApp,
          centerTitle: true,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colorBox,
                    boxShadow: [
                      BoxShadow(
                        color: colorBoxShadow,
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
                        listImage[widget.part],
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
                            '${listSentencesDone[widget.part]}',
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
                                '${listSentencesRight[widget.part]}',
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
                                value: listProgress[widget.part],
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
                    height: 230,
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    decoration: BoxDecoration(
                      color: colorBox,
                      border: Border.symmetric(),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: colorBoxShadow,
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Text(listDirectionEng[widget.part]),
                                  ),
                                  Divider(),
                                  Text(
                                    listDirectionVn[widget.part],
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "",
                          style: TextStyle(fontSize: 16),
                          children: [
                            TextSpan(
                                text: "Nâng cấp",
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline)),
                            TextSpan(
                                text:
                                    ' để tải toàn bộ bài tập về máy, tải dữ liệu nhanh hơn, ổn định hơn',
                                style: TextStyle(
                                  color: textColor,
                                ))
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
                                height: 30,
                                decoration: BoxDecoration(
                                  color: colorBox,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: colorBoxShadow,
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
                                          child: Text(""),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 10,
                                          ),
                                          child: Text(
                                            _dropDownValue,
                                            style: TextStyle(color: textColor),
                                          ),
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
                  _isTest
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              color: Color.fromARGB(255, 255, 123, 0),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '4m 20s',
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        )
                      : SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 20),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      listTapWidget[widget.part]));
                        },
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(), backgroundColor: colorApp),
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
        ));
  }
}
