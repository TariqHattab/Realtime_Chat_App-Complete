import 'package:chat_app/widgets/bubble_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, snapshotUser) {
        if (snapshotUser.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
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
            // print(documents[0].documentID);
            // if (documents[0] == null) {
            //   return Center(
            //     child: Text('The chat is empity'),
            //   );
            // }
            return ListView.builder(
              reverse: true,
              itemCount: documents.length,
              itemBuilder: (ctx, index) => BubbleMessage(
                message: documents[index]['text'],
                isMe: documents[index]['userId'] == snapshotUser.data.uid,
                key: ValueKey(documents[index].documentID),
                username: documents[index]['username'],
              ),
            );
          },
        );
      },
    );
  }
}
