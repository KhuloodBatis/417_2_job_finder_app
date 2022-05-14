import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_app/constant.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../Models/User.dart';
import '../../Providers/Modal_hud.dart';
import '../../Providers/company_data.dart';
import '../../Providers/user_data.dart';
import '../../Widgets/auth_button.dart';
import '../../Widgets/text_field.dart';

class CompanyProfile extends StatelessWidget {
  static String id='CompanyProfileId';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController=TextEditingController();
    TextEditingController nameController=TextEditingController();
    TextEditingController phoneController=TextEditingController();
    TextEditingController addressController=TextEditingController();
    UserModel? userModel=Provider.of<CompanyData>(context).user;
    emailController.text=userModel.email;
    nameController.text=userModel.name;
    phoneController.text=userModel.phone;
    addressController.text=userModel.address;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        backgroundColor: kColor,
      ),
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isChange,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      InkWell(
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
                      Text(userModel.name , style: TextStyle(color: Colors.grey , fontWeight: FontWeight.w500),),
                      Text(userModel.phone),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        MyTextField(label: 'Email', picon: const Icon(Icons.email, color: Colors.purple) , controller: emailController,
                          disable: true,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return 'Please enter your email';
                            }
                          },),
                        const SizedBox(height: 20,),
                        MyTextField(label: 'Name', picon: const Icon(Icons.person, color: Colors.purple) , controller: nameController,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return 'Please enter your Name';
                            }
                          },),
                        const SizedBox(height: 20,),
                        MyTextField(label: 'Phone', picon: const Icon(Icons.phone, color: Colors.purple) , controller: phoneController,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return 'Please enter your Phone';
                            }
                          },),
                        const SizedBox(height: 20,),
                        MyTextField(label: 'Address', picon: const Icon(Icons.phone, color: Colors.purple) , controller: addressController,
                          validate: (value){
                            if(value!.isEmpty)
                            {
                              return 'Please enter your Address';
                            }
                          },),
                        const SizedBox(height: 25,),
                        AuthButton(
                            tap: () async {
                              final instance = Provider.of<ModalHud>(context, listen: false);
                              instance.changeIsLoading(true);
                              if (_globalKey.currentState!.validate()) {
                                _globalKey.currentState!.save();
                                if (nameController.text.length < 3)
                                {
                                  instance.changeIsLoading(false);
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Name Should be at least 3 character'),));
                                }
                                else if (phoneController.text.length < 9)
                                {
                                  instance.changeIsLoading(false);
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Phone Number should be at lest 9 numbers'),));
                                }
                                else
                                {
                                  try
                                  {
                                    await FirebaseFirestore.instance.collection('Users').doc(userModel.id).update(
                                        {
                                          'name' : nameController.text,
                                          'phone': phoneController.text,
                                          'address' : addressController.text,
                                        }
                                    ).then((value) {
                                      Provider.of<CompanyData>(context,listen: false).updateUserDate(phone: phoneController.text, name: nameController.text , address: addressController.text);
                                      instance.changeIsLoading(false);
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Updated'),backgroundColor: Colors.green,));
                                    });
                                  }
                                  catch (e) {
                                    print(e);
                                    List<String> a = e.toString().split(']');
                                    instance.changeIsLoading(false);
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${a[1].substring(1)}'),));
                                  }
                                }
                              }
                              else
                              {
                                instance.changeIsLoading(false);
                              }

                            },
                            text: 'Update'),

                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );

  }
}
