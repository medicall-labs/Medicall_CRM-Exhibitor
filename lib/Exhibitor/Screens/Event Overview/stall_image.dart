import 'package:flutter/material.dart';
import 'package:medicall_exhibitor/Constants/app_color.dart';
import 'package:medicall_exhibitor/Constants/styles.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewer extends StatefulWidget {
  final String pdfPath;
  const PDFViewer({Key? key, required this.pdfPath}) : super(key: key);

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.secondary,
          title: Text(
            'Stall Layout',
            style: AppTextStyles.header2,
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SfPdfViewer.network(
            widget.pdfPath,
            controller: _pdfViewerController,
          ),
        ),
      ),
    );
  }
}
