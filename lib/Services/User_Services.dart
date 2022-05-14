
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:job_app/Models/Applied_job.dart';
import 'package:job_app/Models/Cv.dart';
import 'package:job_app/Models/Post.dart';
import 'package:job_app/Models/User.dart';
import 'package:job_app/Providers/company_data.dart';
import 'package:job_app/Providers/user_data.dart';
import 'package:job_app/Services/Auth_Services.dart';
import 'package:job_app/constant.dart';
import 'package:provider/provider.dart';

class UserServices {

  Future<List<Post>> getAllPosts({required String userId , required context}) async
  {
    List<Post> posts = [];

    await FirebaseFirestore.instance.collection('Posts').get().then((value)  async
    {
      late Post post;
      bool isMatch=false;
        await getAppliedPosts(userId: userId).then((applied) {
          Provider.of<UserData>(context,listen: false).applied=applied;

          for(int i=0 ; i<value.docs.length; i++)
            {
              for(int j = 0; j < applied.length ; j++)
              {
                if(applied[j].postId==Post.fromJson(value.docs[i].data()).id)
                  {
                    post=Post.fromJson(value.docs[i].data());
                    post.isApplied=true;
                    isMatch=true;
                    break;
                  }
              }
              print('b3d el lob');
              if(isMatch)
                {
                  posts.add(post);
                  isMatch=false;
                }
              else
                {
                  posts.add(Post.fromJson(value.docs[i].data()));
                  isMatch=false;
                }
              print('${posts.length} b3d kol add');
            }
        });
    });
    print(posts.length);
    return posts;
  }

  Future<List<AppliedJob>> getAppliedPosts({required String userId}) async
  {
    List<AppliedJob> appliedPosts = [];
    await FirebaseFirestore.instance.collection('Applied').where(
        'userId', isEqualTo: userId).get().then((value) =>
    {
      for(int i = 0; i < value.docs.length; i++)
        {
          appliedPosts.add(AppliedJob.fromJson(value.docs[i].data())),
        }
    });
    return appliedPosts;
  }

  Future<void> applyForJob({required AppliedJob job , required String appliedNumber}) async
  {
    await FirebaseFirestore.instance.collection('Applied').doc().set(
        job.toJson()).then((value) {
          updateAppliedNumber(id: job.postId ,appliedNumber: appliedNumber);
    });
  }
  Future<void> updateAppliedNumber({required String id , required String appliedNumber}) async
  {
    int lastNumber=int.parse(appliedNumber)+1;
    String newNumber=lastNumber.toString();
    await FirebaseFirestore.instance.collection('Posts').doc(id).update(
        {
         'appliedNumber' : newNumber,
        });
  }
  Future<String> uploadPdf({required File file , required String cvName,required String cvId , required String userId , required String category
  ,required String userName , required String jobTitle ,required String userImage
  }) async
  {
    final ref=FirebaseStorage.instance.ref().child('Cvs').child(cvName);
    await ref.putFile(file);
    final url=await ref.getDownloadURL();
    CvModel cv=CvModel(
        id: cvId,
        userId: userId,
        cv: url,
        category: category,
        userName: userName,
        jobTitle: jobTitle,
        userImage: userImage,
    );
    savePdf(cv: cv);
    return url;
  }
  Future<void> savePdf({required CvModel cv}) async
  {
    await FirebaseFirestore.instance.collection('Cv').doc().set(cv.toJson());
    await FirebaseFirestore.instance.collection('Users').doc(cv.userId).update(
      {
        'cv' : cv.cv
      }
    );
  }
  Future<String> uploadProfieImage ({required File image , required context , required String filePath}) async
  {
    final ref=FirebaseStorage.instance.ref().child(filePath).child('${getRandomId()}.jpg');
    await ref.putFile(image);
    final url=await ref.getDownloadURL();
    UserModel user= filePath=='Company' ? Provider.of<CompanyData>(context,listen: false).user : Provider.of<UserData>(context,listen: false).user;
    await FirebaseFirestore.instance.collection('Users').doc(user.id).update(
        {
          'image' : url,
        }
    );
    return url;
  }

}