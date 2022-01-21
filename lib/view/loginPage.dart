// ignore_for_file: file_names, prefer_const_constructors, missing_return, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import 'package:weight_tracker/Animation/fadeAnimation.dart';
import 'package:weight_tracker/common.dart';
import 'package:weight_tracker/functions/loginRegister.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  var size;

  var width;
  var heightMultiplier;
  var widthMultiplier;
  final _key = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    width = MediaQuery.of(context).size.width;
    heightMultiplier = size.height / 100;
    widthMultiplier = size.width / 100;

    return Scaffold(
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
                              "Login",
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
                                    controller: username,
                                    text: "Email",
                                    icon: Icons.person,
                                    width: widthMultiplier),
                                SizedBox(
                                  height: 20,
                                ),
                                passwordField(
                                    controller: password,
                                    text: "Password",
                                    width: widthMultiplier),
                                GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusScopeNode());
                                    if (_key.currentState.validate()) {
                                      loginUser(
                                          email: username.text,
                                          context: context,
                                          password: password.text);
                                    }
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    margin: EdgeInsets.fromLTRB(15, 40, 15, 5),
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[400],
                                              offset: Offset(0, 7),
                                              blurRadius: 5)
                                        ]),
                                    child: Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: white,
                                            fontFamily: medium,
                                            fontSize: widthMultiplier * 4),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "New User?",
                                        style: TextStyle(
                                            color: textColor,
                                            fontFamily: light,
                                            fontSize: widthMultiplier * 3.5),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Text(
                                          "Register Now",
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontFamily: light,
                                              fontSize: widthMultiplier * 3.5),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
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
