//  pre_const_constructors, camel_case_types, prefer_final_fields, non_constant_identifier_names, prefer_const_constructors_in_immutables

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, prefer_final_fields, unnecessary_new, sized_box_for_whitespace, prefer_const_constructors_in_immutables, non_constant_identifier_names, duplicate_ignore, unused_local_variable, unnecessary_null_comparison, import_of_legacy_library_into_null_safe, prefer_typing_uninitialized_variables, deprecated_member_use

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:labour_app_wg/Allscreens/RegistrationScreen.dart';
import 'package:labour_app_wg/DBconnection.dart';
import 'package:labour_app_wg/main.dart';

import '../AllWidgets/progressDialog.dart';
import '../Assitants/FetchingAddress.dart';
import '../Models/Users.dart';
import 'loginscreen.dart';
import 'profilePage.dart';

class mainscreen extends StatefulWidget {
  static const String idScreen = "mian";
  mainscreen({Key? key}) : super(key: key);

  @override
  State<mainscreen> createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> with TickerProviderStateMixin {
  Completer<GoogleMapController> _controllerGooglrMap = Completer();
  late GoogleMapController newgoogleMapController;

  late Position currentPosition;

  var geolocator = Geolocator();

  double bottempadding = 0.0;
//Current location Function
  void locatePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

// Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        diplaymessage("Location is not Enabled", context);
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLatposition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLatposition, zoom: 14);
    newgoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String Address =
        await AssistantMethods.searchCoordinateAddress(position, context);
  }

//Initial Location
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  //initial state to retrieve Logedin user Details
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String profilepic = "";
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("labours")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        profilepic = loggedInUser.imagePath.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("GetWork"),
      ),
      drawer: Container(
        color: Colors.white,
        width: 230.0,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 150.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white10,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 60.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: (profilepic == "")
                                ? AssetImage('images/as.png')
                                : NetworkImage(profilepic) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 25.0,
                          ),
                          Text(
                            "${loggedInUser.firstName?.toUpperCase()}",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "${loggedInUser.email} ",
                            style: TextStyle(fontSize: 15.0),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Divider(),
              SizedBox(height: 10.0),
              ListTile(
                title: Text("${loggedInUser.email}"),
                subtitle: Text("edit acount"),
                leading: Icon(Icons.person),
                trailing: Icon(Icons.edit),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePage(
                                edituser: loggedInUser,
                              )));
                },
              ),
              ListTile(
                title: Text("History"),
                leading: Icon(Icons.history),
                trailing: Icon(Icons.edit),
              ),
              ListTile(
                title: Text("About"),
                leading: Icon(Icons.account_box_rounded),
              ),
              ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.logout_rounded),
                onTap: () {
                  logout(context);
                },
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            padding: EdgeInsets.only(bottom: bottempadding),
            mapType: MapType.normal,
            compassEnabled: true,
            mapToolbarEnabled: true,
            tiltGesturesEnabled: false,
            initialCameraPosition: _kGooglePlex,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: (GoogleMapController Controller) {
              _controllerGooglrMap.complete(Controller);
              newgoogleMapController = Controller;
              locatePosition();
              setState(() {
                bottempadding = 300.0;
              });
            },
          ),
          Positioned(
            top: 30.0,
            left: 60.0,
            right: 0.0,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      GoOnline();
                    },
                    color: Color.fromARGB(255, 23, 196, 46),
                    textColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 45.0,
                        width: 150.0,
                        child: Text(
                          "Go Online",
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void GoOnline() async {
    Geofire.initialize("availableLabours");
    Geofire.setLocation(loggedInUser.lid.toString(), currentPosition.latitude,
        currentPosition.longitude);
    DatabaseReference reqRef = DBconnecntion.connection();
    reqRef.onValue.listen((event) {});
  }

  Future<void> logout(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Loging in.. Please Wait . . . .",
          );
        });
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Loginscreen()));
    } catch (er) {
      Fluttertoast.showToast(msg: er.toString());
      Navigator.pop(context);
      print(er);
    }
  }
}
