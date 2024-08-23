import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Authentication {
  //To save the data to firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // For authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

// For signup
  Future<String> signupUser(
      {required String email,
      required String password,
      required String name}) async {
    String res = "error";
    try {
      //to register user with email and password
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      //To add details to the cloud firestore
      await _firestore.collection("user").doc(credential.user!.uid).set({
        'name': name,
        'email': email,
        'uid': credential.user!.uid,
      });
      res = "success";
    } catch (e) {
      print(e.toString());
    }
    return res;
  }
}
