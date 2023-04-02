import 'dart:math';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toeic_app/constants.dart';
import 'dart:ui' as ui;

class Certificate extends StatelessWidget {
  final int readingScore, listeningScore;
  const Certificate(
      {super.key, required this.listeningScore, required this.readingScore});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Awsome Toeic",
              style: TextStyle(
                  color: colorApp, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.orange[600],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(150, 50),
                      topRight: Radius.elliptical(150, 50))),
              height: 40,
              width: 220,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "LISTENING AND READING",
                    style: TextStyle(
                        fontSize: 10,
                        color: black,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    " OFFICAL SCORE CERTIFICATE ",
                    style: TextStyle(
                        fontSize: 14,
                        color: black,
                        fontWeight: FontWeight.w900),
                  )
                ],
              ),
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.orange,
            ),
          ),
          width: double.infinity,
          height: 300,
          child: CustomPaint(
            size: Size(double.infinity, 300),
            painter: MyPainter(
                listeningScore: listeningScore, readingScore: readingScore),
          ),
        )
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  final int readingScore, listeningScore;
  const MyPainter({required this.listeningScore, required this.readingScore});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    Offset startingPoint = Offset(5, 10);
    Offset endingPoint = Offset(5, 70);
    canvas.drawLine(startingPoint, endingPoint, paint);

    startingPoint = Offset(5, 130);
    endingPoint = Offset(5, 190);
    canvas.drawLine(startingPoint, endingPoint, paint);

    startingPoint = Offset(5, 220);
    endingPoint = Offset(5, 280);
    canvas.drawLine(startingPoint, endingPoint, paint);

    startingPoint = Offset(5, 40);
    endingPoint = Offset(size.width / 2, 40);
    canvas.drawLine(startingPoint, endingPoint, paint);

    startingPoint = Offset(5, 70);
    endingPoint = Offset(size.width / 6, 70);
    canvas.drawLine(startingPoint, endingPoint, paint);

    startingPoint = Offset(size.width / 2, 10);
    endingPoint = Offset(size.width / 2, 280);
    canvas.drawLine(startingPoint, endingPoint, paint);

    startingPoint = Offset(size.width * 4 / 5, 10);
    endingPoint = Offset(size.width * 4 / 5, 280);
    canvas.drawLine(startingPoint, endingPoint, paint);

    startingPoint = Offset(5, 150);
    endingPoint = Offset(size.width * 4 / 5 - 10, 150);
    canvas.drawLine(startingPoint, endingPoint, paint);

    startingPoint = Offset(5, 240);
    endingPoint = Offset(size.width / 2, 240);
    canvas.drawLine(startingPoint, endingPoint, paint);

    startingPoint = Offset(5, 280);
    endingPoint = Offset(size.width / 6, 280);
    canvas.drawLine(startingPoint, endingPoint, paint);

    startingPoint = Offset(size.width / 4, 280);
    endingPoint = Offset(size.width / 4 + size.width / 6 - 5, 280);
    canvas.drawLine(startingPoint, endingPoint, paint);

    startingPoint = Offset(5, 190);
    endingPoint = Offset(size.width / 6, 190);
    canvas.drawLine(startingPoint, endingPoint, paint);

    startingPoint = Offset(size.width / 4, 190);
    endingPoint = Offset(size.width / 4 + size.width / 6 - 5, 190);
    canvas.drawLine(startingPoint, endingPoint, paint);

    startingPoint = Offset(size.width / 4, 130);
    endingPoint = Offset(size.width / 4, 190);
    canvas.drawLine(startingPoint, endingPoint, paint);

    startingPoint = Offset(size.width / 4, 220);
    endingPoint = Offset(size.width / 4, 280);
    canvas.drawLine(startingPoint, endingPoint, paint);

    TextSpan span = TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 12), text: "Name");
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(10, 50));

    String? name = FirebaseAuth.instance.currentUser?.displayName;
    span = TextSpan(
      style: TextStyle(
          color: Colors.black, fontSize: 12, fontWeight: FontWeight.w700),
      text: name,
    );
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(10, 20));

    span = TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 12),
        text: "Indentification");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(10, 155));

    span = TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 12), text: "Number");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(10, 170));

    span = TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 12),
        text: "Date of Birth");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(size.width / 4 + 5, 155));

    span = TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 12),
        text: "(yyyy/mm/dd)");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(size.width / 4 + 5, 170));

    span = TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 12), text: "Test Date");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(10, 245));

    DateTime now = DateTime.now();
    span = TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w700),
        text:
            "${now.year}/${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(10, 225));

    span = TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 12),
        text: "(yyyy/mm/dd)");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(10, 260));

    span = TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 12),
        text: "Valid Until");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(size.width / 4 + 5, 245));

    span = TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w700),
        text:
            "${now.year + 2}/${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(size.width / 4 + 5, 225));

    span = TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 12),
        text: "(yyyy/mm/dd)");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(size.width / 4 + 5, 260));

    span = TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        text: "LISTENING");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    paint.color = Colors.orange;
    Rect rect = Rect.fromLTWH(
        (size.width * 4 / 5 - size.width / 2 - tp.width) / 2 +
            size.width / 2 -
            5,
        20,
        tp.width + 10,
        tp.height + 10);
    canvas.drawRect(rect, paint);
    tp.paint(
        canvas,
        Offset(
            (size.width * 4 / 5 - size.width / 2 - tp.width) / 2 +
                size.width / 2,
            25));

    span = TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
        text: "TOTAL \nSCORE");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    rect = Rect.fromLTWH(
        (size.width - size.width * 4 / 5 - tp.width) / 2 +
            size.width * 4 / 5 -
            5,
        20,
        tp.width + 10,
        tp.height + 10);
    canvas.drawRect(rect, paint);
    tp.paint(
        canvas,
        Offset(
            (size.width - size.width * 4 / 5 - tp.width) / 2 +
                size.width * 4 / 5,
            25));

    span = TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        text: "READING");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    paint.color = Colors.orange;
    rect = Rect.fromLTWH(
        (size.width * 4 / 5 - size.width / 2 - tp.width) / 2 +
            size.width / 2 -
            10,
        160,
        tp.width + 20,
        tp.height + 10);
    canvas.drawRect(rect, paint);
    tp.paint(
        canvas,
        Offset(
            (size.width * 4 / 5 - size.width / 2 - tp.width) / 2 +
                size.width / 2,
            165));

    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(size.width * 9 / 10, 150), 30, paint);

    span = TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
        text: "${listeningScore + readingScore}");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(size.width * 9 / 10 - tp.width / 2, 140));

    span = TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300),
        text: "5");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(size.width / 2 + 5, 125));

    span = TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300),
        text: "495");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(
        canvas, Offset(size.width / 2 + 17 + size.width * 3 / 10 - 40, 125));

    paint.style = PaintingStyle.fill;
    paint.shader = ui.Gradient.linear(
        Offset(size.width / 2 + 15, 125),
        Offset(size.width / 2 + 15 + size.width * 3 / 10 - 40, 125),
        [Colors.white, Colors.black]);
    canvas.drawRect(
        Rect.fromLTWH(size.width / 2 + 15, 125, size.width * 3 / 10 - 40, 15),
        paint);

    span = TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300),
        text: "5");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(size.width / 2 + 5, 260));

    span = TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300),
        text: "495");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(
        canvas, Offset(size.width / 2 + 17 + size.width * 3 / 10 - 40, 260));

    paint.style = PaintingStyle.fill;
    paint.shader = ui.Gradient.linear(
        Offset(size.width / 2 + 15, 260),
        Offset(size.width / 2 + 15 + size.width * 3 / 10 - 40, 260),
        [Colors.white, Colors.black]);
    canvas.drawRect(
        Rect.fromLTWH(size.width / 2 + 15, 260, size.width * 3 / 10 - 40, 15),
        paint);

    double progress = size.width * 3 / 10 - 40;
    double readingProgress = readingScore / 495 * progress;
    double listeningProgress = listeningScore / 495 * progress;

    var path = Path();

    paint.shader = null;
    path.moveTo(size.width / 2 + 10 + listeningProgress, 110);
    path.lineTo(size.width / 2 + 20 + listeningProgress, 110);
    path.lineTo(size.width / 2 + 15 + listeningProgress, 120);
    path.close();
    canvas.drawPath(path, paint);

    path.moveTo(size.width / 2 + 10 + readingProgress, 245);
    path.lineTo(size.width / 2 + 20 + readingProgress, 245);
    path.lineTo(size.width / 2 + 15 + readingProgress, 255);
    path.close();
    canvas.drawPath(path, paint);

    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(
        Offset(size.width / 2 + 15 + listeningProgress, 95), 15, paint);
    canvas.drawCircle(
        Offset(size.width / 2 + 15 + readingProgress, 230), 15, paint);

    span = TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
        text: "$listeningScore");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas,
        Offset(size.width / 2 + 15 + listeningProgress - tp.width / 2, 87.5));

    span = TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
        text: "$readingScore");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas,
        Offset(size.width / 2 + 15 + readingProgress - tp.width / 2, 222.5));

    span = TextSpan(
        style: TextStyle(
            color: Colors.black, fontSize: 10, fontWeight: FontWeight.w300),
        text: "Your score");
    tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(
        canvas,
        Offset(
            min(size.width / 2 + 5 + listeningProgress,
                size.width * 4 / 5 - tp.width - 5),
            65));
    tp.paint(
        canvas,
        Offset(
            min(size.width / 2 + 5 + readingProgress,
                size.width * 4 / 5 - tp.width - 5),
            200));
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
