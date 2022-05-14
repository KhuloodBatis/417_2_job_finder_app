class AppliedJob
{
  late String postId;
  late String jobTitle;
  late String companyName;
  late String userId;
  late String userName;
  late String userCv;
  late String userMail;
  late String userPhone;
  late String userImage;
  late String userAddress;
  late String state;
  String? docId;

  AppliedJob({required this.postId ,required this.userName,required this.jobTitle, required this.companyName ,required this.userImage,required this.userId ,required this.userCv,required this.userMail ,required this.userAddress ,required this.userPhone , required this.state});
  AppliedJob.fromJson(Map<String,dynamic> map)
  {
    if(map==null)
      {
        return;
      }
    else
      {
        postId=map['postId'];
        companyName=map['companyName'];
        userId=map['userId'];
        userMail=map['userMail'];
        userAddress=map['userAddress'];
        userPhone=map['userPhone'];
        jobTitle=map['jobTitle'];
        userCv=map['userCv'];
        userImage=map['userImage'];
        userName=map['userName'];
        state=map['state'];
      }
  }

  toJson()
  {
    return {
      'postId':postId,
      'companyName':companyName,
      'userId' : userId,
      'userCv' : userCv,
      'userMail':userMail,
      'userAddress' :userAddress,
      'userPhone' : userPhone,
      'jobTitle' : jobTitle,
      'userImage':userImage,
      'userName':userName,
      'state':state,
    };
  }

}