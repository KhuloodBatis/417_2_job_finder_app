import 'package:flutter/material.dart';
import 'package:job_app/Models/User.dart';
import 'package:job_app/Providers/company_data.dart';
import 'package:job_app/Screens/Company/chat_screen.dart';
import 'package:job_app/constant.dart';
import 'package:provider/provider.dart';

class ChatListItem extends StatelessWidget {
  UserModel user;
  String myId;
  ChatListItem({required this.user , required this.myId});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(user.name),
          subtitle: Text(user.email),
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: NetworkImage(user.image),
                  fit: BoxFit.fill,
                )
            ),
          ),
          onTap: (){
            String chatId=getChatID(user.id, myId);
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(name: user.name, photo: user.image, userId: user.id, myId: myId, chatId: chatId),));
          },

        ),
        Divider(),
      ],
    );
  }
}
