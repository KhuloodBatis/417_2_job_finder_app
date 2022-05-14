
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_app/Models/User.dart';
import 'package:job_app/Providers/Modal_hud.dart';
import 'package:job_app/Providers/company_data.dart';
import 'package:job_app/Providers/user_data.dart';
import 'package:job_app/Screens/Company/Company_home_screen.dart';
import 'package:job_app/Screens/User/User_home_screen.dart';
import 'package:provider/provider.dart';

class Auth
{
  FirebaseAuth _auth=FirebaseAuth.instance;
  final CollectionReference _userCollection=FirebaseFirestore.instance.collection('Users');

  Future<void> signIn({required String email , required String password ,required context}) async
  {
    await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
      _userCollection.doc(value.user?.uid).get().then((value2) {
        var type = (value2)['type'];
        UserModel userModel=UserModel(
          email: (value2)['email'],
          id: value.user!.uid,
          name: (value2)['name'],
          image: (value2)['image'],
          address: (value2)['address'],
          phone: (value2)['phone'],
          type: (value2)['type'],
          cv: (value2)['cv'],
        );
        if(userModel.cv ==' ')
          {
            print('fouaddddddddddd');
          }
        final instance = Provider.of<ModalHud>(context, listen: false);
        if(type=='User')
        {
          Provider.of<UserData>(context , listen: false).setUser(userModel);
          instance.changeIsLoading(false);
          Navigator.pushReplacementNamed(context, UserHomeScreen.id);
        }
        else if (type=='Company')
        {
          Provider.of<CompanyData>(context , listen: false).setUser(userModel);
          instance.changeIsLoading(false);
          Navigator.pushReplacementNamed(context, CompanyHomeScreen.id);
        }
      });
    });
  }
  Future<void> createAccount({required String name, required String email ,required String password,required String phone , required String address ,required String type,context}) async
  {

    await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user) async {
      UserModel userModel=UserModel(
        id: user.user!.uid,
        name: name,
        email: email,
        type: type,
        address: address,
        phone: phone,
        cv: '',
        image: '',
      );
      await Adduserdata(userModel);
      if(type=='User')
        {
          Provider.of<UserData>(context , listen: false).setUser(userModel);

        }
      else
        {
          Provider.of<CompanyData>(context , listen: false).setUser(userModel);
        }
    });

  }
  Future<void> Adduserdata(UserModel userModel) async
  {
    return await _userCollection.doc(userModel.id).set(userModel.toJson());
  }

  Future<void> signOut() async
  {
    await _auth.signOut();
  }
}