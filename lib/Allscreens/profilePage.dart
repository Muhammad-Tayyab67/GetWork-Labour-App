// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_cast, non_constant_identifier_names, duplicate_ignore

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:labour_app_wg/Allscreens/mainscreen.dart';

import '../Models/Users.dart';

class ProfilePage extends StatefulWidget {
  final UserModel edituser;
  const ProfilePage({Key? key, required this.edituser}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  bool editstatus = true;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FocusNode myFocusNode = FocusNode();
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURL;

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileupdateController = TextEditingController();
  TextEditingController emailupdateController = TextEditingController();
// picking the image

  Future imagePickerMethod() async {
    final pick = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 85);
    setState(() {
      editstatus = false;
      if (pick != null) {
        _image = File(pick.path);
      } else {
        Fluttertoast.showToast(msg: "Image is not Selected");
      }
    });
  }

  //Uploading Image
  Future UploadImageMethod(
    File img,
  ) async {
    final imgId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance
        .ref()
        .child("${widget.edituser.lid}/Images")
        .child("post_$imgId");
    await reference.putFile(img);
    widget.edituser.imagePath = await reference.getDownloadURL();
    await firebaseFirestore
        .collection("labours")
        .doc(widget.edituser.lid)
        .update(
          widget.edituser.toMap(),
        );
  }

  Future UpdateDATA() async {
    if (nameController.text.length < 2) {
      Fluttertoast.showToast(msg: "Please Enter Name..");
    }
    if (mobileupdateController.text.length < 11) {
      Fluttertoast.showToast(msg: "Wrong Number");
    }
    if (!emailupdateController.text.contains("@gmail.com")) {
      Fluttertoast.showToast(msg: "Envalid Email");
    } else {
      widget.edituser.firstName = nameController.text;
      widget.edituser.email = emailupdateController.text;
      widget.edituser.mobileNo = mobileupdateController.text;
      await firebaseFirestore
          .collection("labours")
          .doc(widget.edituser.lid)
          .update(
            widget.edituser.toMap(),
          );
      setState(() {
        _status = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Container(
      color: Colors.white,
      child: new ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Container(
                height: 250.0,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 20.0),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    mainscreen.idScreen, (route) => false);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 22.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 25.0),
                              child: Text(
                                  '${widget.edituser.firstName?.toUpperCase()}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      fontFamily: 'sans-serif-light',
                                      color: Colors.black)),
                            )
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                                width: 140.0,
                                height: 140.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: (_image == null)
                                          ? (AssetImage('images/as.png'))
                                          : (FileImage(_image!)
                                              as ImageProvider),
                                      fit: BoxFit.cover),
                                )),
                          ],
                        ),
                        !_status
                            ? _getCamIcon()
                            : Padding(
                                padding: EdgeInsets.only(),
                              ),
                        !editstatus
                            ? _getOKIcon(_image!)
                            : Padding(
                                padding: EdgeInsets.only(),
                              ),
                      ]),
                    )
                  ],
                ),
              ),
              new Container(
                color: Color(0xffFFFFFF),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: <Widget>[
                                  Text(
                                    'Parsonal Information',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  _status ? _getEditIcon() : new Container(),
                                ],
                              )
                            ],
                          )),
                      Padding(
                          // ignore: prefer_const_constructors
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Name',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    hintText: "Enter Name",
                                  ),
                                  enabled: !_status,
                                  autofocus: !_status,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: <Widget>[
                                  const Text(
                                    'Email ID',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  controller: emailupdateController,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Email ID"),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text(
                                    'Mobile No',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Flexible(
                                child: new TextField(
                                  controller: mobileupdateController,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Mobile Number"),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          )),
                      !_status ? _getActionButtons() : new Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }

  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getCamIcon() {
    return Padding(
        padding: EdgeInsets.only(top: 90.0, right: 100.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: (() {
                imagePickerMethod();
                editstatus = false;
              }),
              child: const CircleAvatar(
                backgroundColor: Colors.red,
                radius: 25.0,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ));
  }

  Widget _getOKIcon(File img) {
    return Padding(
        padding: EdgeInsets.only(top: 90.0, right: 100.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: (() async {
                UploadImageMethod(_image!);
                setState(() {
                  editstatus = true;
                });
              }),
              child: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 78, 248, 35),
                radius: 25.0,
                child: Icon(
                  Icons.check_outlined,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ));
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: const Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    UpdateDATA();
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: const Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: const CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
