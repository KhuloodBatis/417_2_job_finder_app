import 'package:flutter/material.dart';
import 'package:job_app/Models/Post.dart';
import 'package:job_app/Models/User.dart';
import 'package:job_app/Providers/user_data.dart';
import 'package:job_app/Widgets/user_post_widget.dart';
import 'package:provider/provider.dart';


class UserAllJobsScreen extends StatefulWidget {
  @override
  _UserAllJobsScreenState createState() => _UserAllJobsScreenState();
}

class _UserAllJobsScreenState extends State<UserAllJobsScreen> {
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
    userInstance=Provider.of<UserData>(context,listen: false).user;
    await Provider.of<UserData>(context,listen: false).getPosts(userId: userInstance.id , context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Companies Pick you !' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text('Apply for the job now ' , style: TextStyle(color: Colors.grey),),
            Divider(),
            Provider.of<UserData>(context).posts.length == 0 ? Container() : Expanded(child: RefreshIndicator(
              onRefresh: () async {
                await getData();
              },
              child: ListView.builder(
                itemBuilder: (context, index) =>UserPostWidget(post:  Provider.of<UserData>(context).posts[index], index: index,),
                itemCount: Provider.of<UserData>(context).posts.length,
                physics: BouncingScrollPhysics(),),
            )),],
        ),
      ),
    );
  }
}
