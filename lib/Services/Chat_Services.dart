import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_app/Models/Message.dart';
import 'package:job_app/Models/User.dart';

import '../constant.dart';

class ChatServices
{



  static Future<void> createChatBetween({required String userId , required String myId , required String chatId}) async
  {
    await FirebaseFirestore.instance.collection('Chats').doc(chatId).set(
        {
          'users' : <String>[userId,myId],
        }
    );
  }

  static  Future<void> sendMessage({required String chatId , required Message message}) async
  {
    await FirebaseFirestore.instance.collection('Chats').doc(chatId).collection(chatId).doc().set(message.toJson());
  }
  static  Future<List<UserModel>> getChatList({required String myId}) async
  {
    List<UserModel> user=[];
    await FirebaseFirestore.instance.collection('Chats').where('users' ,arrayContains: myId).get().then((value) async {
      for(int i=0 ; i<value.docs.length ; i++)
        {
          print(value.docs[i]['users'][0]);
          print(value.docs[i]['users'][1]);
          if(value.docs[i]['users'][0]==myId)
            {
              await getUserById(userId: value.docs[i]['users'][1]).then((value) {
                user.add(value);
              });
            }
          else
            {
              await getUserById(userId: value.docs[i]['users'][0]).then((value) {
                user.add(value);
              });
            }
        }
    });
    return user;
  }
  static Future<UserModel> getUserById({required String userId}) async
  {
    late UserModel userModel;
    await FirebaseFirestore.instance.collection('Users').doc(userId).get().then((value) {
      userModel=UserModel.fromJson(value.data()!);
    });

    return userModel;
  }
}