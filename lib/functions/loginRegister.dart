// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:weight_tracker/view/homePage.dart';

UserCredential userCredential;

Future registerUser(
    {String email,
    String password,
    String username,
    BuildContext context}) async {
  try {
    userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    FirebaseFirestore.instance
        .collection("userData")
        .doc(userCredential.user.uid)
        .set({
      "userName": username,
      "email": email,
      'userId': userCredential.user.uid,
      "password": password,
    });

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("The account has been created")));
    Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
      return const HomePage();
    }));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a strong password")));
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("The account already exist with this email")));
    }
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
}

Future loginUser({String email, String password, BuildContext context}) async {
  try {
    userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
      return const HomePage();
    }));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No user found for this email")));
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Wrong password provided for this user")));
    }
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
}
