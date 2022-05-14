import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_app/Models/Cv.dart';
import 'package:job_app/Screens/Company/View_Cv_Screen.dart';

import '../constant.dart';

class ShowCvWidget extends StatelessWidget {
  CvModel cvModel;
  ShowCvWidget({required this.cvModel});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: cvModel.userImage !='' ? NetworkImage(cvModel.userImage) as ImageProvider : AssetImage('assets/images/user.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: 15,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cvModel.userName,  style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w500),),
                    Text(cvModel.jobTitle , style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 10,),

                    Text(cvModel.category, style: TextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 5,),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                  onTap: () async {
                    if(cvModel.cv !='')
                    {
                      final doc = await PDFDocument.fromURL(cvModel.cv).then((value) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCvScreen(doc: value, userName: cvModel.userName),));
                      });
                    }
                  },
                  child: Text('View Cv' , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w500 , color: kColor),)),
            ],
          ),
        ),
      ),
    );

  }
}
