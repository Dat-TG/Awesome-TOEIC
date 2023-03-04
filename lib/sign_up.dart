import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toeic_app/sign_in.dart';
import 'package:toeic_app/main.dart';
import 'constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameText = TextEditingController();
  TextEditingController emailText = TextEditingController();
  TextEditingController phoneText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController verifyPasswordText = TextEditingController();
  bool _passwordVisible = false;
  final formKey = GlobalKey<FormState>();
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng ký"),
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
              height: 10,
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
                          cursorColor: colorApp,
                          controller: nameText,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (name) =>
                              name == "" ? 'Vui lòng nhập tên' : null,
                          decoration: InputDecoration(
                              icon: Icon(Icons.alternate_email_sharp, size: 30),
                              labelText: "Tên",
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: colorApp, width: 2.0),
                              ),
                              contentPadding: EdgeInsets.only(left: 20)))),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 20, right: 20, bottom: 10),
                      child: TextFormField(
                          cursorColor: colorApp,
                          controller: emailText,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) => email == ""
                              ? 'Vui lòng nhập Email'
                              : email != "" && !EmailValidator.validate(email!)
                                  ? 'Email không hợp lệ'
                                  : null,
                          decoration: InputDecoration(
                              icon: Icon(Icons.email_outlined, size: 30),
                              labelText: "Email",
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: colorApp, width: 2.0),
                              ),
                              contentPadding: EdgeInsets.only(left: 20)))),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 20, right: 20, bottom: 10),
                      child: TextFormField(
                          controller: phoneText,
                          cursorColor: colorApp,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (phone) => phone == ""
                              ? 'Vui lòng nhập số điện thoại'
                              : null,
                          decoration: InputDecoration(
                              icon: Icon(Icons.phone, size: 30),
                              labelText: "Số điện thoại",
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: colorApp, width: 2.0),
                              ),
                              contentPadding: EdgeInsets.only(left: 20)))),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 20, right: 20, bottom: 10),
                      child: TextFormField(
                          cursorColor: colorApp,
                          controller: passwordText,
                          obscureText: !_passwordVisible,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (pass) => pass == ""
                              ? 'Vui lòng nhập mật khẩu'
                              : pass != "" && pass!.length < 6
                                  ? 'Mật khẩu có ít nhất 6 ký tự'
                                  : null,
                          decoration: InputDecoration(
                              icon: Icon(Icons.lock_outline_rounded, size: 30),
                              labelText: "Mật khẩu",
                              border: OutlineInputBorder(),
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
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: colorApp, width: 2.0),
                              ),
                              contentPadding: EdgeInsets.only(left: 20)))),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 20, right: 20, bottom: 10),
                      child: TextFormField(
                          cursorColor: colorApp,
                          controller: verifyPasswordText,
                          obscureText: !_passwordVisible,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (pass) => pass == ""
                              ? 'Vui lòng nhập xác nhận mật khẩu'
                              : pass != "" && pass != passwordText.text
                                  ? 'Mật khẩu không trùng khớp'
                                  : null,
                          decoration: InputDecoration(
                              icon: Icon(Icons.lock_outline_rounded, size: 30),
                              labelText: "Xác nhận mật khẩu",
                              border: OutlineInputBorder(),
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
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: colorApp, width: 2.0),
                              ),
                              contentPadding: EdgeInsets.only(left: 20)))),
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
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: ElevatedButton(
                        onPressed: () async {
                          final isValidate = formKey.currentState!.validate();
                          if (!isValidate) return;
                          showDialog(
                              context: context,
                              builder: (context) => Center(
                                    child: CircularProgressIndicator(),
                                  ));

                          try {
                            final userCredential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: emailText.text.trim(),
                                    password: passwordText.text.trim());
                            if (userCredential.additionalUserInfo!.isNewUser) {
                              await userCredential.user
                                  ?.updateDisplayName(nameText.text.trim());
                            }

                            navigatorKey.currentState
                                ?.popUntil((route) => route.isFirst);
                          } on FirebaseAuthException catch (e) {
                            print('${e.code} ----- ${e.message}');
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');

                            if (e.code == 'email-already-in-use') {
                              setState(() {
                                error = "Email này đã được sử dụng trước đó";
                              });
                            } else {
                              setState(() {
                                error = e.code;
                              });
                            }
                          }
                        },
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
      ),
    );
  }
}
