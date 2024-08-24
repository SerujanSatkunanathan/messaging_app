import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RequestListPage extends StatefulWidget {
  const RequestListPage({super.key});

  @override
  _RequestListPageState createState() => _RequestListPageState();
}

class _RequestListPageState extends State<RequestListPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> respondToRequest(String requestId, String response) async {
    try {
      await _firestore.collection('friend_requests').doc(requestId).update({
        'status': response,
      });

      if (response == 'accepted') {
        final requestDoc =
            await _firestore.collection('friend_requests').doc(requestId).get();
        final senderId = requestDoc.data()!['senderId'];
        final currentUserId = _auth.currentUser!.uid;

        await _firestore.collection('friends').add({
          'userId1': currentUserId,
          'userId2': senderId,
        });
        await _firestore.collection('friends').add({
          'userId1': senderId,
          'userId2': currentUserId,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request $response')),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = _auth.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Friend Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('friend_requests')
            .where('receiverId', isEqualTo: currentUserId)
            .where('status', isEqualTo: 'pending')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading requests'));
          }

          final requests = snapshot.data!.docs;

          if (requests.isEmpty) {
            return const Center(child: Text('No friend requests'));
          }

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index].data() as Map<String, dynamic>;
              final requestId = requests[index].id;
              final senderId = request['senderId'];

              return ListTile(
                title: Text('Request from user ID: $senderId'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () => respondToRequest(requestId, 'accepted'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => respondToRequest(requestId, 'rejected'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
