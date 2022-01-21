// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, unnecessary_new

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/Animation/fadeAnimation.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:weight_tracker/Provider/userDataProvider.dart';
import 'package:weight_tracker/common.dart';

String formattedDate = DateFormat('kk:mm:ss').format(DateTime.now());

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController weight = TextEditingController();
  final _slideController = SlidableController();

  String formattedDate =
      DateFormat('kk:mm:ss \nEEE d MMM').format(DateTime.now());

  Widget drawerItem({Function function, String title, IconData icon}) {
    return ListTile(
      onTap: function,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: medium,
          fontSize: widthMultiplier * 3.5,
        ),
      ),
      leading: Icon(
        icon,
        color: primaryColor,
      ),
    );
  }

  var size;

  var width;
  var heightMultiplier;
  var widthMultiplier;
  DataProvider provider;
  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<DataProvider>(context);
    provider.getWeight;
    provider.getUserWeight();
    provider.user;
    provider.getUserData();
    size = MediaQuery.of(context).size;
    width = MediaQuery.of(context).size.width;
    heightMultiplier = size.height / 100;
    widthMultiplier = size.width / 100;
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: SafeArea(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      children: provider.user.map((e) {
                    return UserAccountsDrawerHeader(
                      accountName: Text(e.name),
                      accountEmail: Text(e.email),
                      arrowColor: Colors.white,
                      decoration: BoxDecoration(color: Colors.green),
                    );
                  }).toList()),
                  drawerItem(
                      title: "Change Password",
                      icon: Icons.lock,
                      function: () {
                        Navigator.of(context).pop();
                        newPassword.text = "";
                        oldPassword.text = "";
                        updatePassword(
                            context: context,
                            oldPassword: oldPassword,
                            newPassword: newPassword,
                            widthMultiplier: widthMultiplier);
                      }),
                  drawerItem(
                      title: "Logout",
                      icon: Icons.logout,
                      function: () async =>
                          await FirebaseAuth.instance.signOut()),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("Weight Tracker",
              style: TextStyle(
                  color: white,
                  fontFamily: medium,
                  fontSize: widthMultiplier * 4)),
          leading: IconButton(
            icon: Icon(Icons.sort, size: widthMultiplier * 8, color: white),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
          ),
        ),
        body: SafeArea(
          child: FadeAnimation(
              0.8,
              FutureBuilder(
                future: provider.getUserWeight(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    CircularProgressIndicator();
                  }

                  return Container(
                      margin: EdgeInsets.all(10),
                      child: provider.getWeight.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: provider.getWeight
                                  .map(
                                    (e) => Slidable(
                                      controller: _slideController,
                                      actionPane: SlidableScrollActionPane(),
                                      secondaryActions: <Widget>[
                                        GestureDetector(
                                          onTap: () async {
                                            weight.text = "";
                                            _slideController.activeState
                                                .close();
                                            updateWeight(
                                                context: context,
                                                id: e.docId,
                                                weight: weight,
                                                widthMultiplier:
                                                    widthMultiplier);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Colors.grey,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Edit",
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            provider.deleteWeight(
                                                docId: e.docId);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Colors.red,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Delete",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      actionExtentRatio: 0.18,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: textColor, width: 1),
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            "${e.weight} kg" ?? "",
                                            style: TextStyle(
                                              color: textColor,
                                              fontFamily: medium,
                                              fontSize: widthMultiplier * 3.2,
                                            ),
                                          ),
                                          trailing: Text(e.time ?? "",
                                              style: TextStyle(
                                                color: textColor,
                                                fontFamily: medium,
                                                fontSize: widthMultiplier * 3.2,
                                              ),
                                              textAlign: TextAlign.center),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList())
                          : Center(
                              child: Text(
                                "No Data Available\nTap + to add new weight",
                                style: TextStyle(
                                  color: textColor,
                                  fontFamily: medium,
                                  fontSize: widthMultiplier * 4,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ));
                },
              )),
        ),
        floatingActionButton: FloatingActionButton(
            elevation: 0.0,
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            onPressed: () {
              weight.text = "";
              addWeight(
                  context: context,
                  widthMultiplier: widthMultiplier,
                  weight: weight);
            }));
  }
}
