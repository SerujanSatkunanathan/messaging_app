import 'package:flutter/material.dart';
import 'package:messaging_app/Login/Screen/loginpage.dart';
import 'package:messaging_app/chat/messages.dart';

class Chatpage extends StatefulWidget {
  final String name;
  const Chatpage({super.key, required this.name});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Space Talk",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.cyanAccent,
              onPressed: () {
                Navigator.pop(context, Loginpage());
              },
              child: const Text(
                "Logout",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Messages(),
            ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      hintText: "Message",
                      enabled: true,
                      contentPadding:
                          EdgeInsets.only(left: 15, bottom: 8, top: 8)),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
