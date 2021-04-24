import 'package:flutter/material.dart';

class BubbleMessage extends StatelessWidget {
  final String message;
  final bool isMe;

  const BubbleMessage({Key key, this.message, this.isMe}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(12),
        ),
        width: 140,
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(
          message,
          style: TextStyle(
              color: Theme.of(context).accentTextTheme.headline6.color),
        ),
      ),
    ]);
  }
}
