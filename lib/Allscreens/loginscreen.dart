// ignore_for_file: deprecated_member_use, prefer_const_constructors, unused_import, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        Alignment,
        BorderRadius,
        BuildContext,
        Colors,
        Column,
        Container,
        EdgeInsets,
        FlatButton,
        Icons,
        Image,
        InputDecoration,
        Key,
        MaterialPageRoute,
        Navigator,
        Padding,
        RaisedButton,
        RoundedRectangleBorder,
        Scaffold,
        SingleChildScrollView,
        SizedBox,
        StatelessWidget,
        Text,
        TextAlign,
        TextField,
        TextInputType,
        TextStyle,
        Widget,
        showDialog;
import 'package:fluttertoast/fluttertoast.dart';

import '../AllWidgets/progressDialog.dart';
import 'RegistrationScreen.dart';
import 'mainscreen.dart';

class Loginscreen extends StatelessWidget {
  static const String idScreen = "login";

  Loginscreen({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Image.asset(
              "images/sexylogo.jpeg",
              alignment: Alignment.center,
              height: 200,
            ),
            Text("Login here In",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand-Bold"),
                textAlign: TextAlign.center),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: (Column(children: [
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailTextEditingController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
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
                        prefixIcon: Icon(Icons.vpn_key),
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
                      if (emailTextEditingController.text == null ||
                          !emailTextEditingController.text.contains("@")) {
                        Fluttertoast.showToast(msg: "Incorrect Email.");
                      } else if (passTextEditingController.text.length < 3) {
                        Fluttertoast.showToast(msg: "Incorrect Password.");
                      } else {
                        signin(emailTextEditingController.text,
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
                          "Sign In",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0, fontFamily: "Brand-Bold"),
                        ),
                      ),
                    ),
                    // ignore: unnecessary_new
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)),
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            RegisterationScreen.idScreen, (route) => false);
                      },
                      child: Text(
                        "Do not have acount , Register here",
                        style:
                            TextStyle(fontSize: 12.0, fontFamily: "Brand-Bold"),
                      ))
                ]))),
          ]),
        ),
      ),
    );
  }

  void signin(String email, String password, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Loging in.. Please Wait . . . .",
          );
        });
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((lid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => mainscreen())),
              });
    } catch (er) {
      Fluttertoast.showToast(msg: er.toString());
      Navigator.pop(context);
      print(er);
    }
  }
}
