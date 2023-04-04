import 'package:flutter/material.dart';
import 'package:toeic_app/constants.dart';

Future cancelDialog(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
          icon: Row(
            children: [
              Icon(
                Icons.warning_amber_sharp,
                color: red,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Bạn có muốn thoát?",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              )
            ],
          ),
          content: Text(
            "Tiến độ của bạn sẽ bị mất nếu bạn thoát bây giờ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            textAlign: TextAlign.justify,
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: red,
                    padding: EdgeInsets.only(left: 25, right: 25)),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(
                  "Thoát",
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                )),
            SizedBox(width: 2),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: white.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      side: BorderSide(color: black)),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Container(
                    decoration: BoxDecoration(),
                    width: 50,
                    child: Center(
                        child: Text(
                      "Ở lại",
                      style: TextStyle(color: black, fontSize: 15),
                      textAlign: TextAlign.center,
                    )))),
            SizedBox(width: 4),
          ],
        );
      });
}
