class CvModel
{
  late String id;
  late String userId;
  late String cv;
  late String category;
  late String userName;
  late String jobTitle;
  late String userImage;
  CvModel({required this.id , required this.userId , required this.cv ,required this.userImage, required this.category , required this.userName , required this.jobTitle});

  CvModel.fromJson(Map<String , dynamic> map)
  {
    if(map==null)
    {
      return;
    }
    else
    {
      id = map['id'];
      jobTitle=map['jobTitle'];
      userId=map['userId'];
      cv=map['cv'];
      userName=map['userName'];
      category=map['category'];
      userImage=map['userImage'];
    }
  }
  toJson()
  {
    return {
      'id' : id,
      'jobTitle' : jobTitle,
      'userId':userId,
      'cv':cv,
      'userName':userName,
      'category' : category,
      'userImage' : userImage,
    };
  }

}