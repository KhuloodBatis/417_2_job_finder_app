import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_app/Models/Applied_job.dart';
import 'package:job_app/Models/Post.dart';
import 'package:job_app/Models/User.dart';
import 'package:job_app/Services/Auth_Services.dart';
import 'package:job_app/Services/Chat_Services.dart';
import 'package:job_app/Services/User_Services.dart';
import 'package:job_app/constant.dart';

class UserData extends ChangeNotifier {
  late UserModel user;
  UserServices userServices = UserServices();
  List<Post> posts = [];
  List<AppliedJob> applied = [];
  List<UserModel> chatList=[];

  PDFDocument? doc;

  setUser(UserModel userModel) {
    this.user = userModel;
  }
  updateUserDate({required String phone , required String name , required String address})
  {
    user.phone=phone;
    user.name=name;
    user.address=address;
    notifyListeners();
  }

  getPosts({required userId, required context}) {
    userServices.getAllPosts(userId: userId, context: context).then((value) {
      posts = value;
      notifyListeners();
    });
  }

  apply(
      {required AppliedJob job, required int postIndex, required String appliedNumber}) {
    userServices.applyForJob(job: job, appliedNumber: appliedNumber).then((
        value) {
      posts[postIndex].isApplied = true;
      notifyListeners();
    });
  }

  Future<void> saveAndUploadCv({required File file, required String cvName, required String cvId, required String jobTitle, required String category}) async
  {
    userServices.uploadPdf(
      file: file,
      cvName: cvName,
      jobTitle: jobTitle,
      cvId: cvId,
      userId: user.id,
      category: category,
      userName: user.name,
      userImage: user.image,
    ).then((value) {
      print(value);
      user.cv = value;
      getPdf();
      notifyListeners();
    });
  }

  getPdf() async
  {
    if (user.cv != '') {
      doc = await PDFDocument.fromURL(user.cv);
      notifyListeners();
    }
  }

  saveAndUploadImage({required ImageSource src , required context}) async
  {
    getImageFromGallery().then((value)
    {
      userServices.uploadProfieImage(image: value , context: context , filePath: 'Profiles').then((value) {
        user.image=value;
        notifyListeners();
      });
    });
  }

  Future<void> logOut() async
  {
    Auth auth=Auth();
    auth.signOut();
  }

  Future<void> getChatList() async
  {
    ChatServices.getChatList(myId: user.id).then((value) {
      chatList=value;
      notifyListeners();
    });
  }
}