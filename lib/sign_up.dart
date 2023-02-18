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
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width > 500
                ? 500
                : MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextEditForm(label: "Tên", icon: Icons.alternate_email_sharp),
                TextEditForm(label: "Username", icon: Icons.email_outlined),
                TextEditForm(label: "SDT", icon: Icons.phone),
                TextEditForm(
                    label: "Password", icon: Icons.lock_outline_rounded),
                TextEditForm(
                    label: "Verify password", icon: Icons.lock_outline_rounded),
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
