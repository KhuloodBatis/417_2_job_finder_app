import 'package:flutter/material.dart';
import 'package:job_app/Providers/company_data.dart';
import 'package:job_app/Services/Chat_Services.dart';
import 'package:job_app/Widgets/chatListItem.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';

class CompanyChatScreen extends StatefulWidget {
  @override
  State<CompanyChatScreen> createState() => _CompanyChatScreenState();
}

class _CompanyChatScreenState extends State<CompanyChatScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getChats();
    });
  }
  getChats(){
    final instance=Provider.of<CompanyData>(context,listen: false);
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
          return ChatListItem(user:Provider.of<CompanyData>(context).chatList[index] , myId: Provider.of<CompanyData>(context).user.id,);
        },
        itemCount: Provider.of<CompanyData>(context).chatList.length,
      ),
    );
  }
}
