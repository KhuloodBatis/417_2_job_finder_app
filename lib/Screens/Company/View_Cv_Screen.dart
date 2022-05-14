import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class ViewCvScreen extends StatelessWidget {
  PDFDocument doc;
  String userName;
  ViewCvScreen({required this.doc , required this.userName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        backgroundColor: kColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Expanded(child: PDFViewer(document: doc,pickerButtonColor: kColor,)),
          ],
        ),
      ),
    );
  }
}
