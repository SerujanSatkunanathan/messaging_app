import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/Login/Screen/loginpage.dart';
import 'package:messaging_app/Login/widget/button.dart';
import 'package:messaging_app/Services/authentication.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Congratulation You "),
              Buttons(
                  onTap: () async {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      text: 'Logout Successfull!',
                    );
                    await Authentication().signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Loginpage()));
                  },
                  text: "Logout")
            ],
          ),
        ),
      ),
    );
  }
}
