import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BubbleMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  final String username;
  final String userImageUrl;

  const BubbleMessage(
      {Key key, this.message, this.isMe, this.username, this.userImageUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(overflow: Overflow.visible, children: [
      Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              width: 140,
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context)
                                .accentTextTheme
                                .headline6
                                .color),
                  ),
                  Text(
                    message,
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context)
                                .accentTextTheme
                                .headline6
                                .color),
                  ),
                ],
              ),
            ),
          ]),
      Positioned(
          top: 0,
          right: isMe ? 125 : null,
          left: isMe ? null : 125,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImageUrl),
          )),
    ]);
  }
}
