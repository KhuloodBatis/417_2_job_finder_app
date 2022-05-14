import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_app/Models/User.dart';
import 'package:job_app/Providers/company_data.dart';
import 'package:job_app/Providers/user_data.dart';
import 'package:job_app/Screens/Auth/Login_Screen.dart';
import 'package:job_app/Screens/Company/Taps/company_chat_screen.dart';
import 'package:job_app/Screens/Company/Taps/company_cvs_screen.dart';
import 'package:job_app/Screens/Company/Taps/company_home_page_screen.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../User/user_chat_list.dart';
import 'Comapny_Profile.dart';

class CompanyHomeScreen extends StatefulWidget {
  static String id='CompanyHomeScreenID';

  @override
  _CompanyHomeScreenState createState() => _CompanyHomeScreenState();
}

class _CompanyHomeScreenState extends State<CompanyHomeScreen> {
  int selectedIndex=0;

  final taps=[
    CompanyHomePageScreen(),
    CompanyCvsScreen(),
    CompanyChatScreen(),
  ];
   

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    UserModel userInstance=Provider.of<CompanyData>(context,listen: true).user;

    return Scaffold(
      drawer:  Drawer(
        child: Scaffold(
          body: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: kColor,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          await Provider.of<CompanyData>(context,listen: false).saveAndUploadImage(src: ImageSource.gallery , context: context);
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: Provider.of<CompanyData>(context,listen:true).user.image!='' ? NetworkImage(Provider.of<CompanyData>(context,listen:true).user.image) as ImageProvider : AssetImage('assets/images/empty.png') ,
                              fit:Provider.of<CompanyData>(context,listen:true).user.image!='' ? BoxFit.fill : BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(userInstance.name , style: TextStyle(fontSize: 18 , color: Colors.white),),
                  ],

                ),
              ),
              /*ListTile(
                title: Text('Chats', style: TextStyle(color: Colors.black),),
                leading: Icon(Icons.message, color: kColor),
                onTap: (){
                  Navigator.pushNamed(context, UserChatList.id);

                },
              ),
               */
              ListTile(
                title: Text('Profile', style: TextStyle(color: Colors.black),),
                leading: Icon(Icons.person, color: kColor),
                onTap: (){
                  Navigator.pushNamed(context, CompanyProfile.id);
                },
              ),
              ListTile(
                title: Text('Log Out', style: TextStyle(color: Colors.black),),
                leading: Icon(Icons.logout, color: kColor),
                onTap: (){
                  Provider.of<CompanyData>(context,listen: false).logOut().then((value) {
                    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false);
                  });
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kColor,
        currentIndex: selectedIndex,
        onTap: (index){
          setState(() {
            selectedIndex=index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home Page',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_format_outlined),
            label: 'Cv\'s',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Chats',
          ),
        ],
      ),
      body: taps[selectedIndex],
    );
  }
}
