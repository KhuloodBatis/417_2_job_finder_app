import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Color kColor=Colors.purple;

String getRandomId()
{
  var rng = new Random();
  String randomName="";
  for (var i = 0; i < 20; i++) {
    randomName += rng.nextInt(100).toString();
  }
  return randomName;
}

String getChatID(String uid, String pid) {
  return uid.hashCode <= pid.hashCode ? uid + '_' + pid : pid + '_' + uid;
}
List<String> categories=
[
  'IT/Software Development',
  'Engineering',
  'Marketing',
  'Testing',
  'UI/Ux Design',
  'Sales',
  'Help Desk',
  'Call Center',
  'Lawyer/Law',
  'Writer and Books',
  'Teacher/Education',
  'Scientist',
];
List<DropdownMenuItem> getitem(List<String> list)
{
  List<DropdownMenuItem> dropdownmenuitem=[];
  for(int i=0 ; i<list.length; i++)
  {
    String type=list[i];
    var newitem=DropdownMenuItem(
      child: Text(type) ,
      value: type,
    );
    dropdownmenuitem.add(newitem);
  }
  return dropdownmenuitem;
}

Future<File> getImageFromGallery() async
{
  File _pickedimage=File('');
  final ImagePicker _picker=ImagePicker();
  final pickedimagefile= await _picker.pickImage(source: ImageSource.gallery);
  if(pickedimagefile != null) {
   _pickedimage = File(pickedimagefile.path);
  }
  return _pickedimage;
}