import 'package:flutter/material.dart';
import 'package:job_app/Providers/user_data.dart';
import 'package:job_app/Widgets/chatListItem.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
class UserChatList extends StatefulWidget {
  static String id='UserChatListId';

  @override
  State<UserChatList> createState() => _UserChatListState();
}

class _UserChatListState extends State<UserChatList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getChats();
    });
  }
  getChats(){
    final instance=Provider.of<UserData>(context,listen: false);
    instance.getChatList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Chats'),
        centerTitle: true,
        backgroundColor: kColor,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ChatListItem(user:Provider.of<UserData>(context).chatList[index] , myId: Provider.of<UserData>(context).user.id,);
        },
        itemCount: Provider.of<UserData>(context).chatList.length,
      ),
    );

  }
}
