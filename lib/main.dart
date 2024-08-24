import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messaging_app/Login/Screen/homepage.dart';
import 'package:messaging_app/Login/Screen/loginpage.dart';
import 'package:messaging_app/Login/Screen/signup.dart';
import 'package:messaging_app/chat/friends_list_page.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeago/timeago.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return const Loginpage();
        },
      ),
    );
  }
}
