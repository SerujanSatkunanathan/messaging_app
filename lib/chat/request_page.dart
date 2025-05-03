import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendRequest(String email) async {
    try {
      if (email.isNotEmpty) {
        final currentUser = _auth.currentUser!;
        final userDoc = await _firestore
            .collection('user')
            .where('email', isEqualTo: email)
            .get();

        if (userDoc.docs.isNotEmpty) {
          final receiverId = userDoc.docs.first.id;
          await _firestore.collection('friend_requests').add({
            'senderId': currentUser.uid,
            'receiverId': receiverId,
            'status': 'pending',
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Request sent to $email')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User not found')),
          );
        }
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending request')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Friend Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Enter email'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                sendRequest(emailController.text.trim());
              },
              child: const Text('Send Request'),
            ),
          ],
        ),
      ),
    );
  }
}
