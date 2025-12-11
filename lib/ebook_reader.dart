import 'dart:async';
import 'package:epub_view/epub_view.dart';
import 'package:annoto/ui_elements/main_appBar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EbookReader extends StatefulWidget {
  const EbookReader({required this.bookBytes, super.key});
  final List<int> bookBytes;

  @override
  State<EbookReader> createState() => _EbookReaderState();
}

class _EbookReaderState extends State<EbookReader> {
  late EpubController _epubController;

  @override
  void initState() {
    super.initState();
    try {
      _epubController = EpubController(
        document: EpubReader.readBook(widget.bookBytes as FutureOr<List<int>>),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error Reading Book Data: $e"),
          duration: Duration(minutes: 1),
        ),
      );
    }
  }

  @override
  void dispose() {
    _epubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scrSize = 0;
    if (kIsWeb) {
      scrSize = 700;
    } else {
      scrSize = MediaQuery.sizeOf(context).height;
    }
    return Scaffold(
      appBar: CustomAppbar(title: "READER"),
      body: Center(
        child: Container(
          width: scrSize,
          child: EpubView(controller: _epubController)
          ),
      ),
    );
  }
}
