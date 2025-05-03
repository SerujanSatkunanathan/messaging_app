import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/Login/Screen/loginpage.dart';
import 'package:messaging_app/chat/chatpage.dart';
import 'package:messaging_app/chat/request_page.dart';
import 'package:messaging_app/chat/requests_list_page.dart';

class FriendsListPage extends StatefulWidget {
  const FriendsListPage({super.key});

  @override
  _FriendsListPageState createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> getUserName(String userId) async {
    try {
      final userDoc = await _firestore.collection('user').doc(userId).get();
      return userDoc.data()?['name'] ?? 'Unknown User';
    } catch (e) {
      return 'Error fetching name';
    }
  }

  Future<int> getUnreadNotificationsCount() async {
    final currentUserId = _auth.currentUser!.uid;
    try {
      final notificationsSnapshot = await _firestore
          .collection('notifications')
          .where('userId', isEqualTo: currentUserId)
          .where('isRead', isEqualTo: false)
          .get();
      return notificationsSnapshot.size;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = _auth.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Space Talk',
          style: TextStyle(
            color: Colors.cyanAccent,
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
          StreamBuilder<int>(
            stream: Stream.fromFuture(getUnreadNotificationsCount()),
            builder: (context, snapshot) {
              int unreadCount = snapshot.data ?? 0;
              return IconButton(
                icon: Stack(
                  children: [
                    const Icon(Icons.notifications),
                    if (unreadCount > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Center(
                            child: Text(
                              '$unreadCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RequestListPage()),
                  );
                },
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
                await _auth.signOut();
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
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('friends')
            .where('userId1', isEqualTo: currentUserId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading friends'));
          }

          final friends = snapshot.data!.docs;

          if (friends.isEmpty) {
            return const Center(child: Text('No friends found'));
          }

          return ListView.builder(
            itemCount: friends.length,
            itemBuilder: (context, index) {
              final friendDoc = friends[index].data() as Map<String, dynamic>;
              final friendId = friendDoc['userId2'];

              return FutureBuilder<String>(
                future: getUserName(friendId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ListTile(
                      title: Text('Loading...'),
                    );
                  }
                  if (snapshot.hasError) {
                    return ListTile(
                      title: Text('Error loading name'),
                    );
                  }

                  final friendName = snapshot.data ?? 'Unknown User';

                  return ListTile(
                    title: Text(friendName),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.chat,
                        color: Colors.cyanAccent,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Chatpage(
                              currentUserId: currentUserId,
                              chatPartnerId: friendId,
                              chatPartnerName: friendName,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
