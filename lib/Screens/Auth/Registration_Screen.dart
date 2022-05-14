import 'package:flutter/material.dart';
import 'package:job_app/Providers/Modal_hud.dart';
import 'package:job_app/Screens/Company/Company_home_screen.dart';
import 'package:job_app/Screens/User/User_home_screen.dart';
import 'package:job_app/Services/Auth_Services.dart';
import 'package:job_app/Widgets/auth_button.dart';
import 'package:job_app/Widgets/text_field.dart';
import 'package:job_app/constant.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  static String id='RegistrationScreenID';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController nameController=TextEditingController();

  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  TextEditingController confirmController=TextEditingController();

  TextEditingController phoneController=TextEditingController();

  TextEditingController addressController=TextEditingController();

  int selectedType=1;
  Auth auth=Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account' , style: TextStyle(color: kColor,),),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: kColor,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isChange,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20 , right: 20),
            child: Form(
              key: _globalKey,
              child: Column(
                children: [
                  MyTextField(label: 'Name', picon: Icon(Icons.person , color: kColor, size: 30,), controller: nameController, validate: (value){}),
                  SizedBox(height: 20,),
                  MyTextField(label: 'Email', picon: Icon(Icons.email , color: kColor, size: 30,), controller: emailController, validate: (value){}),
                  SizedBox(height: 20,),
                  MyTextField(label: 'Password', picon: Icon(Icons.lock , color: kColor, size: 30,),security: true, controller: passwordController, validate: (value) {}),
                  SizedBox(height: 20,),
                  MyTextField(label: 'Confirm Password', picon: Icon(Icons.lock , color:kColor, size: 30,),security: true, controller: confirmController, validate: (value){}),
                  SizedBox(height: 20,),
                  MyTextField(label: 'Phone Number', picon: Icon(Icons.phone , color:kColor, size: 30,), controller: phoneController, validate: (value){}),
                  SizedBox(height: 20,),
                  MyTextField(label: 'Address (Country/City)', picon: Icon(Icons.home , color: kColor, size: 30,), controller: addressController, validate: (value){}),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Row(children: [
                      Radio(
                        value: 1,
                        groupValue: selectedType,
                        onChanged: (int? value){
                          setState(() {
                            selectedType=value!;
                          });
                        },

                        activeColor:  kColor,
                      ),
                      Text('Job Seeker'),
                    ],),
                    Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: selectedType,
                          onChanged: (int? value){
                            setState(() {
                              selectedType=value!;
                            });
                          },
                          activeColor:  kColor,
                        ),
                        Text('Job Provider'),
                      ],
                    ),
                  ],),
                  Center(child: AuthButton(
                    tap: () async {
                      final instance = Provider.of<ModalHud>(context, listen: false);
                      instance.changeIsLoading(true);
                      if (_globalKey.currentState!.validate())
                      {
                        try {
                          await auth.createAccount(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            phone: phoneController.text,
                            address: addressController.text,
                            type: selectedType==1 ? 'User' : 'Company',
                            context: context,
                          );
                          instance.changeIsLoading(false);
                          if(selectedType==1)
                            {
                              Navigator.pushNamedAndRemoveUntil(context, UserHomeScreen.id , (route)=> false);

                            }
                          else {
                            Navigator.pushNamedAndRemoveUntil(context, CompanyHomeScreen.id , (route)=> false);

                          }
                        }
                        catch (e) {
                          instance.changeIsLoading(false);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email Must be Unique'),));
                        }
                      }
                    }, text: 'Create',),),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      SizedBox(width: 5,),
                      InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text('Login here' , style: TextStyle(fontWeight: FontWeight.w500 , color: kColor),)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
