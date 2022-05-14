import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_app/Models/User.dart';
import 'package:job_app/Providers/user_data.dart';
import 'package:provider/provider.dart';

import 'message_bubble.dart';


class MessageList extends StatelessWidget {

  String chatId;
  String myId;
  MessageList({required this.chatId , required this.myId});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Chats').doc(chatId).collection(chatId).orderBy('date' , descending: true).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasData)
          {
            final docs=snapshot.data!.docs;
            return ListView.builder(
              reverse: true,
              itemCount: docs.length,
              itemBuilder: (context, index) {
                if(docs[index]['idFrom'] == myId)
                {
                  return MessageBubble(isme: true, message: docs[index]['message'],);
                }
                else
                {
                  return MessageBubble(isme: false, message: docs[index]['message'],);
                }
              },
            );
          }
        else {
          return Center(child: Text('Loading...'),);
        }

      },


    );
  }
}
