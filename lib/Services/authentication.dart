import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  // To save the data to Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // For authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // For signup
  Future<String> signupUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = "error";
    try {
      if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
        // To register user with email and password
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // To add details to Firestore
        await _firestore.collection("user").doc(credential.user!.uid).set({
          'name': name,
          'email': email,
          'uid': credential.user!.uid,
        });

        res = "success";
      } else {
        res = "Please fill all the fields";
      }
    } catch (e) {
      return res = e.toString();
    }
    return res;
  }

  // For login
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "error";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please fill all the fields";
      }
    } catch (e) {
      return res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
