import 'package:flutter/material.dart';

import '../constants.dart';

class TimeRemindPickerListTile extends StatefulWidget {
  const TimeRemindPickerListTile({super.key});

  @override
  State<TimeRemindPickerListTile> createState() =>
      _TimeRemindPickerListTileState();
}

class _TimeRemindPickerListTileState extends State<TimeRemindPickerListTile> {
  String trailing = timeRemind;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Thời gian"),
      trailing: Text(trailing),
      contentPadding: EdgeInsets.only(right: 40),
      onTap: () async {
        int hour = int.parse(timeRemind.split(":")[0]);
        if (timeRemind.substring(timeRemind.length - 2) == "PM" && hour != 12) {
          hour += 12;
        }
        if (timeRemind.substring(timeRemind.length - 2) == "AM" && hour == 12) {
          hour = 0;
        }
        final TimeOfDay? TimePick = await showTimePicker(
            context: context,
            initialTime: TimeOfDay(
                hour: hour,
                minute: int.parse(timeRemind.split(":")[1].substring(0, 2))),
            initialEntryMode: TimePickerEntryMode.input);
        // ignore: use_build_context_synchronously
        timeRemind = TimePick != null
            // ignore: use_build_context_synchronously
            ? TimePick.format(context)
            : timeRemind;
        setState(() {
          trailing = timeRemind;
        });
      },
    );
  }
}
