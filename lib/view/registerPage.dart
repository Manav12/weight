// ignore_for_file: file_names, prefer_const_constructors, missing_return, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:weight_tracker/Animation/fadeAnimation.dart';
import 'package:weight_tracker/common.dart';
import 'package:weight_tracker/functions/loginRegister.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  var size;

  var width;
  var heightMultiplier;
  var widthMultiplier;
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController conformPassword = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    width = MediaQuery.of(context).size.width;
    heightMultiplier = size.height / 100;
    widthMultiplier = size.width / 100;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FadeAnimation(
              0.7,
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16.0,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          color: textColor,
                          size: heightMultiplier * 4,
                        ),
                      ),
                    ),
                    SizedBox(height: heightMultiplier * 10),
                    Container(
                      padding: EdgeInsets.only(
                          left: widthMultiplier * 8,
                          right: widthMultiplier * 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Register",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: textColor,
                                  fontFamily: medium,
                                  fontSize: widthMultiplier * 8),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Form(
                              key: _key,
                              child: Column(
                                children: [
                                  textField(
                                      icon: Icons.person,
                                      text: "Username",
                                      width: widthMultiplier,
                                      controller: username),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  textField(
                                      icon: Icons.email,
                                      text: "Email",
                                      width: widthMultiplier,
                                      controller: email),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  passwordField(
                                      controller: password,
                                      text: "Password",
                                      width: widthMultiplier),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  passwordField(
                                      controller: conformPassword,
                                      text: "Conform Password",
                                      width: widthMultiplier),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 10, 20, 10),
                                              margin: EdgeInsets.fromLTRB(
                                                  15, 40, 15, 5),
                                              decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey[400],
                                                        offset: Offset(0, 7),
                                                        blurRadius: 5)
                                                  ]),
                                              child: Center(
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: white,
                                                      fontFamily: medium,
                                                      fontSize:
                                                          widthMultiplier * 4),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              if (_key.currentState
                                                  .validate()) {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        FocusScopeNode());

                                                if (password.text !=
                                                    conformPassword.text) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            "Password Doesn't Match ")),
                                                  );
                                                } else {
                                                  registerUser(
                                                      email: email.text,
                                                      password: password.text,
                                                      context: context,
                                                      username: username.text);
                                                }
                                              }
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 10, 20, 10),
                                              margin: EdgeInsets.fromLTRB(
                                                  15, 40, 15, 5),
                                              decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey[400],
                                                        offset: Offset(0, 7),
                                                        blurRadius: 5)
                                                  ]),
                                              child: Center(
                                                child: Text(
                                                  "Register",
                                                  style: TextStyle(
                                                      color: white,
                                                      fontFamily: medium,
                                                      fontSize:
                                                          widthMultiplier * 4),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
