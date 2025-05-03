import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  final String currentUserId;
  final String chatPartnerId;

  const Messages({
    super.key,
    required this.currentUserId,
    required this.chatPartnerId,
  });

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  late Stream<QuerySnapshot> _messageStream;

  @override
  void initState() {
    super.initState();
    _messageStream = FirebaseFirestore.instance
        .collection(
            'messages') // Ensure this matches the collection name used in Chatpage
        .where('time',
            isGreaterThan: DateTime.now()
                .subtract(const Duration(days: 7))) // Adjust as needed
        .orderBy('time')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Filter messages client-side
        final filteredMessages = snapshot.data!.docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final senderId = data['senderId'];
          final receiverId = data['receiverId'];
          return (senderId == widget.currentUserId ||
                  senderId == widget.chatPartnerId) &&
              (receiverId == widget.currentUserId ||
                  receiverId == widget.chatPartnerId);
        }).toList();

        return ListView.builder(
          itemCount: filteredMessages.length,
          itemBuilder: (context, index) {
            QueryDocumentSnapshot qds = filteredMessages[index];
            Timestamp time = qds['time'];
            DateTime dateTime = time.toDate();

            // Cast to Map<String, dynamic> and safely extract fields
            Map<String, dynamic> data = qds.data() as Map<String, dynamic>;
            String senderId = data['senderId'];
            String message = data['message'];
            bool isCurrentUser = senderId == widget.currentUserId;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                crossAxisAlignment: isCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300,
                    child: ListTile(
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.cyanAccent),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      title: Text(
                        message,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Expanded(
                            child: Text(
                              message,
                              softWrap: true,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                              "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
