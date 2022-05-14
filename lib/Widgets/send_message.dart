import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_app/Models/Message.dart';
import 'package:job_app/Models/User.dart';
import 'package:job_app/Providers/user_data.dart';
import 'package:provider/provider.dart';


class SendMessageWidget extends StatefulWidget {
  String uniqe;
  SendMessageWidget({required this.uniqe});
  @override
  _SendMessageWidgetState createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {

  TextEditingController controller=TextEditingController();
  String _enterMessage="";
  _sendMessage(String id){
    FocusScope.of(context).unfocus();
    Message message=Message(
      date: DateTime.now(),
      idFrom: '',
      message: controller.text,
      idTo: ''
    );
    FirebaseFirestore.instance.collection('Chat').add(message.toJson());
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user=Provider.of<UserData>(context,listen: false).user;
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(hintText: 'Send a message...' ,
                suffixIcon: GestureDetector(

                    onTap: (){
                      if(_enterMessage.trim().isEmpty)
                        {

                        }
                      else {
                        _sendMessage(user.id);
                      }
                    },
                    child: Icon(Icons.send)),

                ),
                onChanged: (valu){

                    _enterMessage=valu;
                },
              ),),
        ],
      ),
    );
  }
}
