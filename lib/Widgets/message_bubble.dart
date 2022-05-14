import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MessageBubble extends StatelessWidget {
  bool isme;
  String message;
  MessageBubble({required this.isme , required this.message});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isme? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: !isme ?Radius.circular(0) : Radius.circular(15),
              bottomRight: isme ? Radius.circular(0) : Radius.circular(15),
            ),
            color: !isme ? Colors.grey.shade700 :Colors.blue,
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4 ,horizontal: 8),
          child: Column(
            crossAxisAlignment: isme ? CrossAxisAlignment.end : CrossAxisAlignment.start ,
            children: [
              Text(message ,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,

              ),
              textAlign: isme ? TextAlign.end : TextAlign.start,),
            ],
          ),
        ),
      ],
    );
  }
}
