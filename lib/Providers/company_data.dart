import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_app/Models/Applied_job.dart';
import 'package:job_app/Models/Cv.dart';
import 'package:job_app/Models/Post.dart';
import 'package:job_app/Models/User.dart';
import 'package:job_app/Services/Auth_Services.dart';
import 'package:job_app/Services/Chat_Services.dart';
import 'package:job_app/Services/Company_Services.dart';
import 'package:job_app/Services/User_Services.dart';
import 'package:job_app/constant.dart';

class CompanyData extends ChangeNotifier
{
  late UserModel user;
  CompanyServices companyServices=CompanyServices();
  List<Post> companyPosts=[];
  List<AppliedJob> appliedInPost=[];
  List<CvModel> Cvs=[];
  List<UserModel> chatList=[];
  setUser(UserModel userModel)
  {
    this.user=userModel;
  }
  updateUserDate({required String phone , required String name , required String address})
  {
    user.phone=phone;
    user.name=name;
    user.address=address;
    notifyListeners();
  }
  getCompanyPosts({required String companyId})
  {
    companyServices.getCompanyPosts(companyId: companyId).then((value) {
      companyPosts=value;
      notifyListeners();
    });
  }
  removeFromCompanyPost({required int index})
  {
    companyPosts.removeAt(index);
    notifyListeners();
  }
  addToCompanyPostList(Post post)
  {
    companyPosts.add(post);
    notifyListeners();
  }
  Future<void> getAppliedForPost({required String postId}) async
  {
    companyServices.getAppiedForPost(postId: postId).then((value) {
       appliedInPost=value;
       notifyListeners();
    });
  }

  Future<void> getCv({required String category}) async
  {
    companyServices.getCvByCategory(category: category).then((value) {
      Cvs=value;
      notifyListeners();
    });
  }

  saveAndUploadImage({required ImageSource src , required context}) async
  {
    getImageFromGallery().then((value)
    {
      UserServices userServices=UserServices();
      userServices.uploadProfieImage(image: value , context: context , filePath: 'Company').then((value) {
        user.image=value;
        notifyListeners();
      });
    });
  }

  Future<void> getChatList() async
  {
    ChatServices.getChatList(myId: user.id).then((value) {
      chatList=value;
      notifyListeners();
    });
  }

  Future<void> logOut() async
  {
    Auth auth=Auth();
    auth.signOut();
  }

}