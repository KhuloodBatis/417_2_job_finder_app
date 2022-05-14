import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_app/Providers/user_data.dart';
import 'package:job_app/Services/User_Services.dart';
import 'package:job_app/Widgets/auth_button.dart';
import 'package:job_app/constant.dart';
import 'package:provider/provider.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';


class UserUploadCvScreen extends StatefulWidget {
  @override
  _UserUploadCvScreenState createState() => _UserUploadCvScreenState();
}

class _UserUploadCvScreenState extends State<UserUploadCvScreen> {
  String selectedCategory='IT/Software Development';
  TextEditingController jobTitleController=TextEditingController();
  UserServices userServices=UserServices();
  FilePickerResult? result;
  File? file;
  String? cvId;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getPdf();
    });
  }
  getPdf() async
  {
    Provider.of<UserData>(context,listen: false).getPdf();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    jobTitleController.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Provider.of<UserData>(context).user.cv=='' ?  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              const Text('Upload Your Cv' , style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Row(
                children: [
                  const Text('Category : ' , style: TextStyle(fontSize: 17),),
                  SizedBox(width: 10,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 35,
                      padding: EdgeInsets.all(5),
                      child: DropdownButton(items: getitem(categories), value:selectedCategory, onChanged: (dynamic value){
                        setState(() {
                          selectedCategory=value;
                        });
                      } ,
                        isDense: true,
                        underline: Container(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Card(
                elevation: 1,
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
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Select Your Cv : ', style: TextStyle(fontSize: 17),),
                  SizedBox(width: 10,),
                  InkWell(
                      onTap: () async {
                        result= await FilePicker.platform.pickFiles();
                        if(result != null)
                        {
                          setState(() {
                            file = File(result!.files.single.path!);
                            cvId=getRandomId();
                          });


                        }
                      },
                      child: Icon(Icons.upload_file , size: 50,)),
                ],
              ),
              SizedBox(height: 20,),
              file != null ? Text('Cv Selected Succsfully') : Text(''),
              SizedBox(height: 40,),
              MaterialButton(
                onPressed: () async  {
                  if(file==null || jobTitleController.text.isEmpty || cvId==null)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Enter all the data')));
                    }
                  else
                    {
                      String fileName='$cvId.pdf';
                      Provider.of<UserData>(context,listen: false).saveAndUploadCv(
                        file: file!,
                        cvName: fileName,
                        cvId: cvId!,
                        jobTitle: jobTitleController.text,
                        category: selectedCategory,
                      );
                    }
                },
                height: 40.0,
                minWidth: 180.0,
                child: Text('Upload',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold , fontSize: 18)),
                color: kColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              )
            ],
          ),
        ),
      ) : Provider.of<UserData>(context).doc == null ? Center(child: CircularProgressIndicator(),) : Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Text('Your Cv Uploaded'),
            SizedBox(height: 10,),
            Expanded(child: PDFViewer(document: Provider.of<UserData>(context).doc!, pickerButtonColor: kColor,)),
          ],
        ),
      ),
    );
  }
}
