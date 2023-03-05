import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toeic_app/constants.dart';

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
  final User? user = FirebaseAuth.instance.currentUser;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _editProfileFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _editProfileFormKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
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
                initialValue: user!.displayName,
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
                initialValue: user!.email,
                enabled: false,
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
                initialValue: user!.phoneNumber,
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
                initialValue: "",
              ),
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: colorApp),
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_editProfileFormKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
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
