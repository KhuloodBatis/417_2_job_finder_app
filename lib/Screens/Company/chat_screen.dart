import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_app/Models/Message.dart';
import 'package:job_app/Services/Chat_Services.dart';
import 'package:job_app/Widgets/message_list.dart';
import 'package:job_app/Widgets/send_message.dart';

import '../../constant.dart';

class ChatScreen extends StatelessWidget {
  static String id='ChatScreenId';
  String name;
  String photo;
  String userId;
  String myId;
  String chatId;
  ChatScreen({required this.name , required this.photo,required this.userId , required this.myId , required this.chatId});
  TextEditingController messageController=TextEditingController();

  void sendMessage() {
    Message message=Message(
        message: messageController.text,
        idFrom: myId,
        idTo: userId,
        date: DateTime.now(),
    );
    ChatServices.sendMessage(chatId: chatId, message: message);
    messageController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                    image: NetworkImage(photo),
                    fit: BoxFit.fill,
                  )
              ),
            ),
            SizedBox(width: 10,),
            Text(name),
          ],
        ),
        backgroundColor: kColor,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: MessageList(myId: myId, chatId: chatId,),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(hintText: 'Send a message...' ,

                        suffixIcon: GestureDetector(

                            onTap: (){
                              if(messageController.text.trim().isNotEmpty)
                              {
                                sendMessage();
                              }
                            },
                            child: Icon(Icons.send)),

                      ),
                    ),),
                ],
              ),
            )
          ],
        ),
      ),
    );

  }
}
