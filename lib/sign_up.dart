import 'package:flutter/material.dart';
import 'package:toeic_app/sign_in.dart';
import 'constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng ký"),
        backgroundColor: colorApp,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  appIcon,
                  width: 120,
                ),
              ],
            ),
          ),
          Text(
            appName,
            style: TextStyle(
                fontSize: 24, color: colorApp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 20, right: 20, bottom: 10),
                child: TextFormField(
                    cursorColor: colorApp,
                    decoration: InputDecoration(
                      icon: Icon(Icons.alternate_email_sharp, size: 30),
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 20, right: 20, bottom: 10),
                child: TextFormField(
                    cursorColor: colorApp,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock_outline_rounded, size: 30),
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 20, right: 20, bottom: 10),
                child: TextFormField(
                    cursorColor: colorApp,
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone, size: 30),
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 20, right: 20, bottom: 10),
                child: TextFormField(
                    cursorColor: colorApp,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock_outline_rounded, size: 30),
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 20, right: 20, bottom: 10),
                child: TextFormField(
                    cursorColor: colorApp,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock_outline_rounded, size: 30),
                      labelText: 'Verify password',
                      border: OutlineInputBorder(),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(), backgroundColor: colorApp),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                        child: Text(
                          'Đăng ký',
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
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Text("---- OR ----"),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
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
                  'Bạn đã có tài khoản ? ',
                  style: TextStyle(fontSize: 17),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  child: Text(
                    'Đăng nhập',
                    style: TextStyle(
                        fontSize: 17,
                        color: colorApp,
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
