import 'package:flutter/material.dart';
import 'package:job_app/Providers/company_data.dart';
import 'package:job_app/Widgets/applied_widget.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class AppliedForPostScreen extends StatelessWidget {
  static String id='AppliedForPostScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applied For post'),
        centerTitle: true,
        backgroundColor: kColor,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.builder(itemBuilder: (context, index) {
          return AppliedWidget(userApply: Provider.of<CompanyData>(context, listen: true).appliedInPost[index],);
        },
        itemCount:  Provider.of<CompanyData>(context, listen: true).appliedInPost.length,
        ),
      ),
    );
  }
}
