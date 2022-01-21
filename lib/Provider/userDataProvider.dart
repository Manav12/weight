// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/Provider/Model/userDate.dart';
import 'package:weight_tracker/Provider/Model/weight.dart';

class DataProvider with ChangeNotifier {
  List<Weight> weight = [];
  Weight weightdata;

  getUserWeight() async {
    List<Weight> newlist = [];
    User currentuser = FirebaseAuth.instance.currentUser;

    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("userWeight")
        .doc(currentuser.uid)
        .collection('Weight')
        .orderBy('time', descending: true)
        .get();
    snap.docs.forEach(
      (element) {
        var weight = element.data() as Map;

        weightdata = Weight(
          weight: weight["Weight"],
          time: weight["time"],
          docId: element.id.toString(),
        );
        newlist.add(weightdata);
      },
    );
    weight = newlist;
    notifyListeners();
  }

  List<Weight> get getWeight {
    return weight;
  }

  addNewWeight({String weight, String time}) {
    User currentuser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("userWeight")
        .doc(currentuser.uid)
        .collection('Weight')
        .doc()
        .set({
      "Weight": weight,
      "time": time,
    });
    notifyListeners();
  }

  updateWeight({String weight, String time, String docId}) {
    User currentuser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("userWeight")
        .doc(currentuser.uid)
        .collection('Weight')
        .doc(docId)
        .update({
      "Weight": weight,
      "time": time,
    });
    notifyListeners();
  }

  deleteWeight({String docId}) {
    User currentuser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("userWeight")
        .doc(currentuser.uid)
        .collection('Weight')
        .doc(docId)
        .delete();
    notifyListeners();
  }

  List<UserData> user = [];
  UserData datalist;

  getUserData() async {
    List<UserData> newlist = [];
    User currentuser = FirebaseAuth.instance.currentUser;

    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection("userData").get();
    snap.docs.forEach(
      (element) {
        var data = element.data() as Map;
        if (currentuser.uid == data['userId']) {
          datalist = UserData(name: data["userName"], email: data["email"]);
          newlist.add(datalist);
        }
      },
    );
    user = newlist;
    notifyListeners();
  }

  List<UserData> get getData {
    return user;
  }
}
