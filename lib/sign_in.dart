// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:toeic_app/auth/facebook_sign_in.dart';
import 'package:toeic_app/auth/google_sign_in.dart';
import 'package:toeic_app/home_page.dart';
import 'package:toeic_app/forgot_password.dart';
import 'package:toeic_app/main.dart';
import 'package:toeic_app/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constants.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  String error = "";
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng nhập"),
        backgroundColor: colorApp,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                      decoration: InputDecoration(
                          icon: Icon(Icons.email_outlined, size: 30),
                          labelText: "Email",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: colorApp, width: 2.0),
                          ),
                          contentPadding: EdgeInsets.only(left: 20))),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 10),
                  child: TextFormField(
                      controller: passwordText,
                      cursorColor: colorApp,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock_outline_rounded, size: 30),
                          labelText: "Mật khẩu",
                          suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              }),
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width > 500
                    ? 500
                    : MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
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
                              .signInWithEmailAndPassword(
                                  email: emailText.text,
                                  password: passwordText.text);
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage(intialIndex: 4)));
                        } on FirebaseAuthException catch (e) {
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                          print(e.code);
                          if (e.code == 'unknown') {
                            setState(() {
                              error = "Vui lòng nhập đủ thông tin";
                            });
                          } else if (e.code == 'invalid-email') {
                            setState(() {
                              error = 'Email không hợp lệ';
                            });
                          } else if (e.code == 'user-not-found') {
                            setState(() {
                              error = 'Không tồn tại email này';
                            });
                          } else if (e.code == 'wrong-password') {
                            setState(() {
                              error = 'Mật khẩu không đúng';
                            });
                          } else {
                            setState(() {
                              error = e.message ?? "";
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(), backgroundColor: colorApp),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                        child: Text(
                          'Đăng nhập',
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text("---- OR ----"),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width > 500
                    ? 500
                    : MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                      onPressed: () async {
                        final result = await signInWithGoogle();
                        print("User");
                        print(result.user?.email);
                        if (result.user != null) {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        intialIndex: 4,
                                      )));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'assets/img/google.png',
                              width: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Đăng nhập bằng Google',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )),
                ),
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width > 500
                    ? 500
                    : MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                      onPressed: () async {
                        final result = await signInWithFacebook();
                        print("User");
                        print(result.user?.email);
                        if (result.user != null) {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        intialIndex: 4,
                                      )));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'assets/img/facebook.png',
                              width: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Đăng nhập bằng Facebook',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                  },
                  child: Text(
                    'Quên mật khẩu',
                    style: TextStyle(
                        fontSize: 17,
                        color: orange,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Bạn chưa có tài khoản ? ',
                  style: TextStyle(fontSize: 17),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text(
                    'Tạo tài khoản',
                    style: TextStyle(
                        fontSize: 17,
                        color: orange,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
