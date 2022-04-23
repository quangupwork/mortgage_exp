import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:flutter/material.dart';

import '../../../widgets/widget.dart';

class PDFViewScreen extends StatefulWidget {
  final String url;
  const PDFViewScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<PDFViewScreen> createState() => _PDFViewScreenState();
}

class _PDFViewScreenState extends State<PDFViewScreen> {
  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  @override
  void dispose() {
    document.clearImageCache();
    super.dispose();
  }

  loadDocument() async {
    document = await PDFDocument.fromURL(widget.url);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.withLeading(title: "Important infomation"),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xff8b745d)))
            : PDFViewer(
                document: document,
                showPicker: false,
              ));
  }
}
