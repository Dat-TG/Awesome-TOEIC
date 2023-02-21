import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toeic_app/others/get_It.dart';
import 'package:toeic_app/settings/time_remind_picker.dart';

import '../constants.dart';
import '../main.dart';

class RemindDialog extends StatefulWidget {
  const RemindDialog({super.key});

  @override
  State<RemindDialog> createState() => _RemindDialogState();
}

class _RemindDialogState extends State<RemindDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(children: [
        AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: SwitchListTile(
                value: isRemind,
                title: Text(
                  "Nhắc nhở học tập",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                secondary: Icon(Icons.alarm, color: colorApp),
                contentPadding: EdgeInsets.zero,
                onChanged: (bool value) => setState(() {
                      isRemind = value;
                      // Save to shared preferences....
                      //
                    })),
            contentPadding: EdgeInsets.zero,
            alignment: Alignment.center,
            content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isRemind)
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text("Chọn thời gian trong ngày"),
                      ),
                    if (isRemind)
                      Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: TimeRemindPickerListTile()),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          final prefs = locator<SharedPreferences>();
                          prefs.setString("TimeRemind", timeRemind);
                          prefs.setBool("isRemind", isRemind);
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          await showRemindNotification();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorApp,
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: Text("Xong"),
                      ),
                    )
                  ],
                ))),
      ]),
    );
  }
}
