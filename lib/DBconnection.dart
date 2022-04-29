import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:labour_app_wg/Config.dart';

import 'Allscreens/mainscreen.dart';

class DBconnecntion {
  static DatabaseReference connection() {
    firebaseuser = FirebaseAuth.instance.currentUser;
    DatabaseReference reqRef = FirebaseDatabase.instance
        .ref()
        .child("labours")
        .child(firebaseuser!.uid)
        .child("newReq");
    return reqRef;
  }

  static logincheck(context) {
    firebaseuser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("labours")
        .doc(firebaseuser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        Fluttertoast.showToast(msg: "Login Successful");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => mainscreen()));
      } else {
        Fluttertoast.showToast(msg: "Login Failed");
        Navigator.pop(context);
      }
    });
  }
}
