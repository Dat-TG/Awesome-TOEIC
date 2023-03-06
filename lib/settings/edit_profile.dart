import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toeic_app/constants.dart';

import '../auth/verify_phone.dart';

// Create a Form widget.
class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  EditProfileFormState createState() {
    return EditProfileFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class EditProfileFormState extends State<EditProfileForm> {
  String? DOB;
  String? displayName;
  String? email;
  String? phone;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _editProfileFormKey = GlobalKey<FormState>();
  TextEditingController nameText = TextEditingController();
  TextEditingController emailText = TextEditingController();
  TextEditingController phoneText = TextEditingController();
  TextEditingController DOBText = TextEditingController();

  Future<void> getInitValue() async {
    Map<String, dynamic>? data;
    String? tempDOB;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => {data = value.data(), tempDOB = data!["DOB"] ?? ""});
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      print("user $user");
      if (user != null) {
        nameText.text = user.displayName ?? "";
        emailText.text = user.providerData[0].email ?? user.email!;
        if (user.phoneNumber != null) {
          phoneText.text = "0${user.phoneNumber?.substring(3)}";
        }
      }
      DOBText.text = tempDOB ?? "";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInitValue().then((value) => {});
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _editProfileFormKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: colorApp,
                    width: 2,
                  )),
                  labelText: 'Tên',
                ),
                controller: nameText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: colorApp,
                    width: 2,
                  )),
                  labelText: 'Email',
                ),
                enabled: false,
                controller: emailText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: colorApp,
                    width: 2,
                  )),
                  labelText: 'Số điện thoại',
                ),
                controller: phoneText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: colorApp,
                    width: 2,
                  )),
                  labelText: 'Ngày sinh',
                ),
                controller: DOBText,
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? date = DateTime(1900);
                  date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    DOBText.text =
                        "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}";
                  }
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: colorApp),
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_editProfileFormKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    try {
                      showDialog(
                          context: context,
                          builder: (context) => Center(
                                child: CircularProgressIndicator(),
                              ));
                      print(
                          "info: ${nameText.text}, ${phoneText.text}, ${DOBText.text}");
                      User? user = FirebaseAuth.instance.currentUser;
                      user?.updateDisplayName(nameText.text);
                      await FirebaseFirestore.instance
                          .collection("Users")
                          .doc(user!.uid)
                          .update({'DOB': DOBText.text});
                      if (phoneText.text != user.phoneNumber) {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: "+84${phoneText.text.substring(1)}",
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
                            Navigator.pop(context);
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyVerify(
                                          vertificationID: verificationId,
                                        )));
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Scaffold(
                                      appBar: AppBar(
                                        centerTitle: true,
                                        title: Text("Chỉnh sửa tài khoản"),
                                        backgroundColor: colorApp,
                                      ),
                                      body: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          EditProfileForm(),
                                        ],
                                      ),
                                    )));
                      }
                    } catch (err) {
                      print(err);
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text('Xác nhận'),
              ),
            ),
            Center(
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Đổi mật khẩu",
                    style: TextStyle(decoration: TextDecoration.underline),
                  )),
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Xóa tài khoản",
                  style: TextStyle(color: red, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
