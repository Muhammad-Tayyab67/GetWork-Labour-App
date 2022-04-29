import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:labour_app_wg/Config.dart';

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
}
