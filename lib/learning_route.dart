import 'package:flutter/material.dart';
import 'package:toeic_app/constants.dart';

class LearningRoute extends StatefulWidget {
  const LearningRoute({super.key});

  @override
  State<LearningRoute> createState() => _LearningRouteState();
}

class _LearningRouteState extends State<LearningRoute> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("./assets/img/route.png"),
        SizedBox(
          height: 10,
        ),
        Text(
          "Chọn lộ trình bạn muốn",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [DropdownButtonGoal(), Text(" điểm TOEIC")],
        ),
        Text(
          "Lộ trình Awesome TOEIC",
          style: TextStyle(
              color: colorApp, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Chinh phục ",
              style: TextStyle(fontSize: 16),
            ),
            ValueListenableBuilder(
              valueListenable: dropdownValue,
              builder: (context, value, child) => Text(
                "${dropdownValue.value} điểm ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "TOEIC",
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 40, right: 40, bottom: 30),
          child: Text(
            "Để bắt đầu, hãy làm một bài kiểm tra đánh giá để có được lộ trình học tập phù hợp",
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Thời gian: ",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              "15 phút",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Số câu hỏi: ",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              "20",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            )
          ],
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(colorApp),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)))),
                child: Text(
                  "Bắt đầu nào",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class DropdownButtonGoal extends StatefulWidget {
  const DropdownButtonGoal({super.key});

  @override
  State<DropdownButtonGoal> createState() => _DropdownButtonGoalState();
}

const List<int> toeicGoal = [500, 700, 900];
ValueNotifier<int> dropdownValue = ValueNotifier(toeicGoal.first);

class _DropdownButtonGoalState extends State<DropdownButtonGoal> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: dropdownValue.value,
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      onChanged: (int? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue.value = value!;
        });
      },
      items: toeicGoal.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }
}
