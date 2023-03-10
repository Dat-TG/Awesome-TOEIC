import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toeic_app/auth/verify_phone.dart';
import 'package:toeic_app/constants.dart';

class TestIntro extends StatefulWidget {
  final String testID;
  final QueryDocumentSnapshot<Map<String, dynamic>>? data;
  const TestIntro({super.key, required this.testID, required this.data});

  @override
  State<TestIntro> createState() => _TestIntroState();
}

class _TestIntroState extends State<TestIntro> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/img/test_background.jpg'))),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Test ${widget.testID}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Thời gian: ",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "120 phút",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Số câu hỏi: ",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "200",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 45,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorApp,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () async {},
                        child: Text("Bắt đầu nào")),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
