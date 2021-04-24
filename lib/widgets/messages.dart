import 'package:chat_app/widgets/bubble_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, snapshotUser) => StreamBuilder(
        stream: Firestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var documents = streamSnapshot.data.documents;
          return ListView.builder(
            reverse: true,
            itemCount: documents.length,
            itemBuilder: (ctx, index) => BubbleMessage(
                message: documents[index]['text'],
                isMe: documents[index]['userId'] == snapshotUser.data.uid),
          );
        },
      ),
    );
  }
}
