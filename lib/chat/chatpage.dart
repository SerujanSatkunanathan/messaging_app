import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/Login/Screen/loginpage.dart';
import 'package:messaging_app/chat/friends_list_page.dart';
import 'package:messaging_app/chat/messages.dart';
import 'package:messaging_app/chat/request_page.dart';
import 'package:messaging_app/chat/requests_list_page.dart';

class Chatpage extends StatefulWidget {
  final String currentUserId;
  final String chatPartnerId;
  final String chatPartnerName;

  const Chatpage({
    super.key,
    required this.currentUserId,
    required this.chatPartnerId,
    required this.chatPartnerName,
  });

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final TextEditingController messagecontroller = TextEditingController();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.chatPartnerName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.group_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RequestPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RequestListPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FriendsListPage()),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.cyanAccent,
              onPressed: () async {
                await firebaseAuth.signOut();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Loginpage()),
                );
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
      body: Column(
        children: [
          Expanded(
            child: Messages(
              currentUserId: widget.currentUserId,
              chatPartnerId: widget.chatPartnerId,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: messagecontroller,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "Message",
                      enabled: true,
                      contentPadding:
                          const EdgeInsets.only(left: 15, bottom: 8, top: 8),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    validator: (value) {
                      return null;
                    },
                    onSaved: (value) {
                      messagecontroller.text = value!;
                    },
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  if (messagecontroller.text.isNotEmpty) {
                    try {
                      await firebaseFirestore.collection("messages").add({
                        'message': messagecontroller.text.trim(),
                        'time': DateTime.now(),
                        'senderId': widget.currentUserId,
                        'receiverId': widget.chatPartnerId,
                      });
                      messagecontroller.clear();
                    } catch (e) {
                      // Handle the error here
                      print("Error sending message: $e");
                    }
                  }
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.cyanAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
