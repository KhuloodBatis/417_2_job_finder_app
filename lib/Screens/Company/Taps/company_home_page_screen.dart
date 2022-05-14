import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_app/Models/Post.dart';
import 'package:job_app/Models/User.dart';
import 'package:job_app/Providers/company_data.dart';
import 'package:job_app/Screens/Auth/Login_Screen.dart';
import 'package:job_app/Services/Company_Services.dart';
import 'package:job_app/Widgets/auth_button.dart';
import 'package:job_app/Widgets/company_post_widget.dart';
import 'package:job_app/constant.dart';
import 'package:provider/provider.dart';

class CompanyHomePageScreen extends StatefulWidget {
  @override
  _CompanyHomePageScreenState createState() => _CompanyHomePageScreenState();
}

class _CompanyHomePageScreenState extends State<CompanyHomePageScreen> {
  CompanyServices companyServices=CompanyServices();

  var scaffoldKey=GlobalKey<ScaffoldState>();
  TextEditingController postController=TextEditingController();
  TextEditingController jobTitleController=TextEditingController();

  late UserModel userInstance;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getData();
    });
  }
  getData() async
  {
     userInstance=Provider.of<CompanyData>(context,listen: false).user;
    await Provider.of<CompanyData>(context,listen: false).getCompanyPosts(companyId: userInstance.id);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    postController.dispose();
    jobTitleController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          scaffoldKey.currentState?.showBottomSheet((context) => Card(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10) , topRight: Radius.circular(10)),
                color: Colors.white,
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.5,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: Provider.of<CompanyData>(context,listen: true).user.image != '' ? NetworkImage(Provider.of<CompanyData>(context,listen:true).user.image) as ImageProvider : AssetImage('assets/images/user.jpg') ,
                            fit:BoxFit.fill
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text('${Provider.of<CompanyData>(context,listen: true).user.name} Company' , style: TextStyle(fontWeight: FontWeight.w600),),
                      SizedBox(height: 5,),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        controller: jobTitleController,
                        validator: (value)
                        {
                          if(value==null)
                          {
                            return 'Enter your job Title';
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'job Title'
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.3,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white70,
                      ),
                      child: TextFormField(
                        controller: postController,
                        validator: (value)
                        {
                          if(value==null)
                            {
                              return 'Enter your post';
                            }
                        },
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Create Your Post !'
                        ),
                      ),
                    ),
                  )),
                  SizedBox(height: 10,),
            MaterialButton(
              onPressed: () async  {
                if(postController.text.isNotEmpty)
                  {
                    Post post=Post(
                        id: getRandomId() ,
                        jobTitle: jobTitleController.text,
                        appliedNumber: '0' ,
                        companyName: Provider.of<CompanyData>(context,listen: false).user.name,
                        companyPhoto: Provider.of<CompanyData>(context,listen: false).user.image,
                        companyId: Provider.of<CompanyData>(context,listen: false).user.id,
                        date: DateTime.now().toString(),
                        post: postController.text,
                        isApplied: false,
                    );
                    companyServices.addNewPost(post).then((value) {
                      Provider.of<CompanyData>(context, listen: false).addToCompanyPostList(post);
                      Navigator.pop(context);
                      postController.clear();
                      jobTitleController.clear();
                    });
                  }
                else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Post is empty'),));
                  }

              },
              height: 50.0,
              minWidth: 200.0,
              child: Text('Post',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold , fontSize: 18)),
              color: kColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            )      ],
              ),
            ),
          ));
        },
        child: Icon(Icons.post_add),
        backgroundColor: kColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text('Need to hire someone ?' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),),
                     SizedBox(height: 5,),
                     Text('Lets Create a Post' , style: TextStyle(color: Colors.grey),),
                   ],
                 ),
                  InkWell(
                    onTap: (){
                      Provider.of<CompanyData>(context,listen: false).logOut().then((value) {
                        Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false);
                      });
                    },

                      child: Icon(Icons.logout , color: kColor,)),
                ],
              ),
              SizedBox(height: 20,),
              Text('Older Posts' , style: TextStyle(fontSize: 18 , color: Colors.grey),),
              Divider(),
              Provider.of<CompanyData>(context).companyPosts.length == 0 ? Container() : Expanded(child: RefreshIndicator(
                onRefresh: () async {
                  await getData();
                },
                child: ListView.builder(
                  itemBuilder: (context, index) =>CompanyPostWidget(post:  Provider.of<CompanyData>(context).companyPosts[index], index: index),
                  itemCount: Provider.of<CompanyData>(context).companyPosts.length,
                  physics: BouncingScrollPhysics(),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
