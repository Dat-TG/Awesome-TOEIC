import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toeic_app/auth/verify_phone.dart';
import 'package:toeic_app/constants.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/phone_verify.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Xác thực số điện thoại",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Chúng tôi cần xác thực số điện thoại của bạn",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.phone,
                      controller: textController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Nhập số điện thoại",
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: colorApp,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: "+84${textController.text.substring(1)}",
                        verificationCompleted:
                            (PhoneAuthCredential credential) {
                          FirebaseAuth.instance.currentUser
                              ?.updatePhoneNumber(credential);
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          Fluttertoast.showToast(
                              msg: "Xác thực số điện thoại không thành công",
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 17,
                              gravity: ToastGravity.BOTTOM);
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyVerify(
                                      vertificationID: verificationId,
                                    )),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    child: Text("Gửi mã code")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
