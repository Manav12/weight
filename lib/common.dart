// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/Provider/userDataProvider.dart';

final _key = GlobalKey<FormState>();
const Color hintTextColor = Color.fromRGBO(144, 144, 144, 1);
const Color headingcolor = Color.fromRGBO(50, 50, 50, 1);
const Color textColor = Color.fromRGBO(50, 50, 50, 1);
const Color white = Colors.white;
const Color primaryColor = Colors.green;

const String bold = "bold";
const String light = "light";
const String medium = "medium";
textField(
    {var width, String text, IconData icon, TextEditingController controller}) {
  return TextFormField(
    controller: controller,
    style:
        TextStyle(color: textColor, fontFamily: medium, fontSize: width * 3.5),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Cannot be null';
      }
      return null;
    },
    decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(color: hintTextColor, fontSize: width * 3.5),
        prefixIcon: Icon(icon)),
  );
}

passwordField({
  double width,
  String text,
  TextEditingController controller,
}) {
  return TextFormField(
    controller: controller,
    style:
        TextStyle(color: textColor, fontFamily: medium, fontSize: width * 3.5),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Cannot be null';
      }
      return null;
    },
    obscureText: true,
    decoration: InputDecoration(
      hintText: text,
      hintStyle: TextStyle(color: hintTextColor, fontSize: width * 3.5),
      prefixIcon: Icon(Icons.lock),
    ),
  );
}

addWeight({
  BuildContext context,
  double widthMultiplier,
  TextEditingController weight,
}) {
  Widget okButton = TextButton(
    child: Text("Add"),
    onPressed: () {
      FocusScope.of(context).requestFocus(FocusScopeNode());
      if (_key.currentState.validate()) {
        DataProvider provider =
            Provider.of<DataProvider>(context, listen: false);
        provider.addNewWeight(
            weight: weight.text,
            time: DateFormat('kk:mm:ss \ndd-MM-yy ')
                .format(DateTime.now())
                .toString());
      }
      ;
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Add new weight"),
    content: Container(
      height: 60,
      child: Form(
        key: _key,
        child: TextFormField(
          style: TextStyle(
            color: textColor,
            fontFamily: medium,
            fontSize: widthMultiplier * 3.2,
          ),
          controller: weight,

          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Cannot be null';
            }
            return null;
          },
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered

          decoration: InputDecoration(
            hintText: "Enter weight in kg",
            hintStyle: TextStyle(
              color: textColor,
              fontFamily: medium,
              fontSize: widthMultiplier * 3.2,
            ),
          ),
        ),
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

updateWeight({
  BuildContext context,
  double widthMultiplier,
  String id,
  TextEditingController weight,
}) {
  Widget okButton = TextButton(
    child: Text("Add"),
    onPressed: () {
      FocusScope.of(context).requestFocus(FocusScopeNode());
      if (_key.currentState.validate()) {
        DataProvider provider =
            Provider.of<DataProvider>(context, listen: false);
        provider.updateWeight(
            docId: id,
            weight: weight.text,
            time: DateFormat('kk:mm:ss \ndd-MM-yy  ')
                .format(DateTime.now())
                .toString());

        Navigator.of(context).pop();
      }
      ;
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Add new weight"),
    content: Container(
      height: 60,
      child: Form(
        key: _key,
        child: TextFormField(
          controller: weight,
          style: TextStyle(
            color: textColor,
            fontFamily: medium,
            fontSize: widthMultiplier * 3.2,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Cannot be null';
            }
            return null;
          },
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered

          decoration: InputDecoration(
            hintText: "Enter weight in kg",
            hintStyle: TextStyle(
              color: textColor,
              fontFamily: medium,
              fontSize: widthMultiplier * 3.2,
            ),
          ),
        ),
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

updatePassword(
    {BuildContext context,
    double widthMultiplier,
    TextEditingController oldPassword,
    TextEditingController newPassword}) {
  Widget okButton = TextButton(
    child: Text("Update"),
    onPressed: () {
      _changePassword(
          newPassword: newPassword.text,
          currentPassword: oldPassword.text,
          context: context);
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Change Password"),
    content: Container(
      height: 100,
      child: Column(
        children: [
          passwordField(
              controller: oldPassword,
              text: "current password",
              width: widthMultiplier),
          passwordField(
              controller: newPassword,
              text: "new password",
              width: widthMultiplier),
        ],
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void _changePassword(
    {String currentPassword, String newPassword, BuildContext context}) async {
  final user = FirebaseAuth.instance.currentUser;
  final cred = EmailAuthProvider.credential(
      email: user.email, password: currentPassword);

  user.reauthenticateWithCredential(cred).then((value) {
    user.updatePassword(newPassword).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("The password is updated")));
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    });
  }).catchError((err) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(err.toString())));
  });
}
