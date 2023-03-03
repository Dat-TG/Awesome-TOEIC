import 'package:flutter/material.dart';
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
                          errorText: "asdasd",
                          errorBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
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
                          labelText: "Password",
                          suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              }),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 20))),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
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
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailText.text,
                                  password: passwordText.text);
                        } on FirebaseAuthException catch (e) {
                          print(e.code);
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
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
                      onPressed: () {},
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
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
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
          )
        ]),
      ),
    );
  }
}

class TextEditForm extends StatefulWidget {
  final String label;
  final IconData icon;
  const TextEditForm({super.key, required this.label, required this.icon});

  @override
  State<TextEditForm> createState() => _TextEditFormState();
}

class _TextEditFormState extends State<TextEditForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
      child: TextFormField(
          cursorColor: colorApp,
          decoration: InputDecoration(
              icon: Icon(widget.icon, size: 30),
              labelText: widget.label,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 20))),
    );
  }
}
