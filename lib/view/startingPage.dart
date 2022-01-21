// ignore_for_file: file_names, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weight_tracker/Animation/fadeAnimation.dart';
import 'package:weight_tracker/common.dart';
import 'package:weight_tracker/view/loginPage.dart';
import 'package:weight_tracker/view/registerPage.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({Key key}) : super(key: key);

  @override
  _StartingPageState createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  var size;

  var width;
  var heightMultiplier;
  var widthMultiplier;
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
                  children: [
                    Container(
                      width: double.infinity,
                      child: Center(
                          child: Image.asset(
                        "assets/images/logo.jpg",
                        height: heightMultiplier * 45,
                      )),
                    ),
                    Text("Welcome To Weight Tracker",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: widthMultiplier * 6,
                          color: Colors.green,
                          fontFamily: bold,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0, right: 15),
                      child: Text(
                          "Keep track of your weight to maintain a healty life style",
                          style: TextStyle(
                            fontSize: widthMultiplier * 3.7,
                            color: textColor,
                            fontFamily: light,
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (builder) {
                          return LoginPage();
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (builder) {
                          return RegisterPage();
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        margin: EdgeInsets.fromLTRB(15, 20, 15, 5),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(20),
                            // border: Border.all(color: Colors.green, width: 2),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[400],
                                  offset: Offset(0, 7),
                                  blurRadius: 5)
                            ]),
                        child: Center(
                          child: Text(
                            "SignUp",
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: medium,
                                fontSize: widthMultiplier * 4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
