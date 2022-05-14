import 'package:flutter/material.dart';
import 'package:job_app/Models/Cv.dart';
import 'package:job_app/Providers/company_data.dart';
import 'package:job_app/Services/Company_Services.dart';
import 'package:job_app/Services/User_Services.dart';
import 'package:job_app/Widgets/show_cv_widget.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';

class CompanyCvsScreen extends StatefulWidget {
  @override
  State<CompanyCvsScreen> createState() => _CompanyCvsScreenState();
}

class _CompanyCvsScreenState extends State<CompanyCvsScreen> {
  String selectedCategory='IT/Software Development';
  getCv() async
  {
    Provider.of<CompanyData>(context,listen: false).getCv(category: selectedCategory);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getCv();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Cv\'s by Category'),
        centerTitle: true,
        backgroundColor: kColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                        getCv();
                      });
                    } ,
                      isDense: true,
                      underline: Container(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Text('Cv in Selected Category' , style: TextStyle(color: Colors.grey),),
            Divider(),
            Provider.of<CompanyData>(context).Cvs.length > 0 ?
            Expanded(
                child: ListView.builder(itemBuilder: (context, index) {
                  return ShowCvWidget(cvModel: Provider.of<CompanyData>(context).Cvs[index]);
                },
                  itemCount: Provider.of<CompanyData>(context).Cvs.length,
                ) ) : Container(),
          ],
        ),
      ),
    );
  }
}
