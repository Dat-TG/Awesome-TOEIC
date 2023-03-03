import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:toeic_app/main.dart';
import 'package:toeic_app/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constants.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  String error = "";
  String success = "";
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset mật khẩu"),
        backgroundColor: colorApp,
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    appIcon,
                    width: 80,
                  ),
                ],
              ),
            ),
            Text(
              appName,
              style: TextStyle(
                  fontSize: 20, color: colorApp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width > 500
                  ? 500
                  : MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 10),
                    child: TextFormField(
                        controller: emailText,
                        cursorColor: colorApp,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) => email == ""
                            ? 'Vui lòng nhập Email'
                            : email != "" && !EmailValidator.validate(email!)
                                ? 'Email không hợp lệ'
                                : null,
                        decoration: InputDecoration(
                            icon: Icon(Icons.email_outlined, size: 30),
                            labelText: "Nhập email xác nhận",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: colorApp, width: 2.0),
                            ),
                            contentPadding: EdgeInsets.only(left: 20))),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              constraints: BoxConstraints(minHeight: 0, maxHeight: 40),
              child: error != ""
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        error,
                        style: TextStyle(
                            fontSize: 17,
                            color: red,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : SizedBox.shrink(),
            ),
            Container(
              constraints: BoxConstraints(minHeight: 0, maxHeight: 40),
              child: success != ""
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        success,
                        style: TextStyle(
                            fontSize: 17,
                            color: green,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : SizedBox.shrink(),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width > 500
                      ? 500
                      : MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: ElevatedButton(
                        onPressed: () async {
                          // Dialog to show status login for user
                          showDialog(
                              context: context,
                              builder: (context) => Center(
                                    child: CircularProgressIndicator(),
                                  ));
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: emailText.text);
                            setState(() {
                              error = "";
                              success = "Link reset mật khẩu đã gửi đi";
                            });
                          } on FirebaseAuthException catch (e) {
                            print(e.code);
                            if (e.code == 'user-not-found') {
                              setState(() {
                                error = 'Không tìm thấy email này';
                                success = "";
                              });
                            } else {
                              error = e.code;
                              success = "";
                            }
                          } finally {
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(), backgroundColor: colorApp),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                          child: Text(
                            'Reset mật khẩu',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
