// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_new, prefer_const_constructors_in_immutables, non_constant_identifier_names, use_key_in_widget_constructors, file_names, unnecessary_import, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:labour_app_wg/DBconnection.dart';
import '../Models/Users.dart';
import 'loginscreen.dart';

// ignore: must_be_immutable
class RegisterationScreen extends StatelessWidget {
  static const String idScreen = "register";
  TextEditingController fnameTextEditingController = TextEditingController();
  TextEditingController lnameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController cityTextEditingController = TextEditingController();
  TextEditingController cnicTextEditingController = TextEditingController();
  TextEditingController passTextEditingController = TextEditingController();
  TextEditingController mobileTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Image.asset(
              "images/applogo.jpeg",
              alignment: Alignment.center,
              height: 200,
            ),
            Text("Register Here",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand-Bold"),
                textAlign: TextAlign.center),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: (Column(children: [
                  TextField(
                    controller: fnameTextEditingController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "First Name",
                        labelStyle: TextStyle(fontSize: 14.0),
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey)),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  TextField(
                    controller: lnameTextEditingController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "Last Name",
                        labelStyle: TextStyle(fontSize: 14.0),
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey)),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  TextField(
                    controller: cnicTextEditingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "CNIC No",
                        labelStyle: TextStyle(fontSize: 14.0),
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey)),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  TextField(
                    controller: cityTextEditingController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                        labelText: "City",
                        labelStyle: TextStyle(fontSize: 14.0),
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey)),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  TextField(
                    keyboardType: TextInputType.phone,
                    controller: mobileTextEditingController,
                    decoration: InputDecoration(
                        labelText: "Mobile No",
                        labelStyle: TextStyle(fontSize: 14.0),
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey)),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  TextField(
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: 14.0),
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey)),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  TextField(
                    obscureText: true,
                    controller: passTextEditingController,
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(fontSize: 14.0),
                        hintStyle:
                            TextStyle(fontSize: 14.0, color: Colors.grey)),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (fnameTextEditingController.text.length < 3) {
                        diplaymessage(
                            "Name should conatain more then 3 alphabets",
                            context);
                      } else if (lnameTextEditingController.text.length < 3) {
                        diplaymessage(
                            "Name should conatain more then 3 alphabets",
                            context);
                      } else if (cityTextEditingController.text.length < 3) {
                        diplaymessage(
                            "Address Must conatain more then 3 Words", context);
                      } else if (passTextEditingController.text.length < 3) {
                        diplaymessage(
                            "Password should conatain more then 3 alphabets",
                            context);
                      } else if (mobileTextEditingController.text.length !=
                          11) {
                        diplaymessage(
                            "Mobile Must conatain more then 11 Digits",
                            context);
                      } else if (cnicTextEditingController.text.length < 3) {
                        diplaymessage(
                            "CINIC should conatain more then 13 Digits",
                            context);
                      } else if (!emailTextEditingController.text
                          .contains("@")) {
                        diplaymessage(
                            "Email should conatain more then @gmail.. alphabets",
                            context);
                      } else {
                        DBconnecntion().signUp(emailTextEditingController.text,
                            passTextEditingController.text, context);
                      }
                    },
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 45.0,
                        width: 150.0,
                        child: Text(
                          "Register Now",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0, fontFamily: "Brand-Bold"),
                        ),
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)),
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Loginscreen.idScreen, (route) => false);
                      },
                      child: Text(
                        "Already have an Acount , Login Here",
                        style:
                            TextStyle(fontSize: 12.0, fontFamily: "Brand-Bold"),
                      ))
                ]))),
          ]),
        ),
      ),
    );
  }

  void postDetailsToFirestore(BuildContext context, FirebaseAuth auth) async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? labours = auth.currentUser;

    // writing all the values
    UserModel labourModel = UserModel();
    labourModel.email = labours!.email;
    labourModel.lid = labours.uid;
    labourModel.firstName = fnameTextEditingController.text;
    labourModel.lastName = lnameTextEditingController.text;
    labourModel.cityName = cityTextEditingController.text;
    labourModel.cnic = cnicTextEditingController.text;
    labourModel.mobileNo = mobileTextEditingController.text;
    labourModel.password = passTextEditingController.text;
    labourModel.imagePath = "";

    await firebaseFirestore
        .collection("labours")
        .doc(labours.uid)
        .set(labourModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushNamedAndRemoveUntil(
        context, Loginscreen.idScreen, (route) => false);
  }
}

diplaymessage(String msg, BuildContext context) {
  Fluttertoast.showToast(msg: msg);
}
