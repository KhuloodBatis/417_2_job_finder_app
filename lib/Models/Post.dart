class Post
{
  late String id;
  late String jobTitle;
  late String companyName;
  late String date;
  late String post;
  late String appliedNumber;
  late String companyPhoto;
  late String companyId;
  bool isApplied=false;
  Post({required this.id ,required this.companyId , required this.jobTitle, required this.companyName , required this.date , required this.post , required this.appliedNumber , required this.companyPhoto , required this.isApplied});

  Post.fromJson(Map<String , dynamic> map)
  {
    if(map==null)
      {
        return;
      }
    else
      {
        id = map['id'];
        jobTitle=map['jobTitle'];
        companyName=map['companyName'];
        date=map['date'];
        post=map['post'];
        appliedNumber=map['appliedNumber'];
        companyPhoto=map['companyPhoto'];
        companyId=map['companyId'];
      }
  }
  toJson()
  {
    return {
      'id' : id,
      'jobTitle' : jobTitle,
      'companyName':companyName,
      'date':date,
      'post':post,
      'appliedNumber' : appliedNumber,
      'companyPhoto':companyPhoto,
      'companyId': companyId,
    };
  }





}