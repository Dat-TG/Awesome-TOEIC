import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toeic_app/constants.dart';

import 'others/get_It.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final List<String> data = ["Test 1", "Test 2", "Test 3", "Test 4", "Test 5"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = locator<SharedPreferences>();
    setState(() {
      isDarkMode = (prefs.getBool('DarkMode') ?? false);
      changeColorByTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            height: 130,
            decoration: BoxDecoration(
              color: colorBox,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: colorBoxShadow,
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data[index],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Icon(
                        Icons.lock,
                        color: colorApp,
                        size: 23,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      children: [
                        Text(
                          'Thời gian',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorApp,
                              fontSize: 15),
                        ),
                        Text(
                          ': 120 phút | ',
                          style: TextStyle(color: colorApp, fontSize: 15),
                        ),
                        Text(
                          'Câu hỏi',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorApp,
                              fontSize: 15),
                        ),
                        Text(
                          ': 200 câu',
                          style: TextStyle(color: colorApp, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print("abc");
                      },
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(), backgroundColor: colorApp),
                      child: Text("Bắt đầu"))
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 4);
      },
    );
  }
}
