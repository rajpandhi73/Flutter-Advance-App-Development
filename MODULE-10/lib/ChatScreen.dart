import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();

  void sendMessage(String text) {
    final user = FirebaseAuth.instance.currentUser;
    if (text.isNotEmpty && user != null) {
      FirebaseFirestore.instance.collection('messages').add({
        'text': text,
        'user': user.email,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (ctx, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: docs.length,
                  itemBuilder: (ctx, index) => ListTile(
                    title: Text(docs[index]['text']),
                    subtitle: Text(docs[index]['user'] ?? ''),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(labelText: 'Enter message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => sendMessage(messageController.text),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
