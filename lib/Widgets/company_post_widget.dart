import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_app/Models/Post.dart';
import 'package:job_app/Providers/company_data.dart';
import 'package:job_app/Screens/Company/Applied_for_post_screen.dart';
import 'package:job_app/Services/Company_Services.dart';
import 'package:job_app/constant.dart';
import 'package:provider/provider.dart';

class CompanyPostWidget extends StatelessWidget {
  late Post post;
  int index;
  CompanyPostWidget({required this.post , required this.index});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: post.companyPhoto != '' ? NetworkImage(post.companyPhoto) as ImageProvider : AssetImage('assets/images/user.jpg') ,
                          fit:BoxFit.fill
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${post.companyName} Company' , style: TextStyle(fontWeight: FontWeight.w600),),
                      SizedBox(height: 5,),
                      Text(post.date , style: TextStyle(color: Colors.grey),),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                      onTap: (){
                        CompanyServices.deletePost(id: post.id).then((value) {
                          Provider.of<CompanyData>(context,listen: false).removeFromCompanyPost(index: index);

                        });
                        },
                      child: Icon(Icons.delete , color: kColor,)),
                ],
              ),
              Divider(),
              Text(post.jobTitle , style: TextStyle(fontWeight: FontWeight.bold),),
              Text(post.post),
              SizedBox(height: 10,),
              InkWell(
                onTap: () async {
                  if(post.appliedNumber !='0')
                    {
                      Provider.of<CompanyData>(context, listen: false).getAppliedForPost(postId: post.id).then((value) {
                        Navigator.pushNamed(context, AppliedForPostScreen.id);
                      });
                    }
                },
                child: Container(
                  color: kColor,
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${post.appliedNumber}', style: TextStyle(fontSize: 18),),
                      SizedBox(width: 10,),
                      Text('Applied' , style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
