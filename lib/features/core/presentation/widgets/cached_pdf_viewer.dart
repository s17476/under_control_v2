import 'dart:io';

import 'package:flutter/material.dart';

import '../../utils/get_cached_firebase_storage_file.dart';
import 'pdf_viewer.dart';

class CachedPdfViewer extends StatefulWidget {
  const CachedPdfViewer({
    Key? key,
    required this.pdfUrl,
  }) : super(key: key);

  final String pdfUrl;

  @override
  State<CachedPdfViewer> createState() => _CachedPdfViewerState();
}

class _CachedPdfViewerState extends State<CachedPdfViewer> {
  File? _cachedPdfFile;

  Future<void> _initPdf() async {
    if (widget.pdfUrl.isNotEmpty) {
      // get cached file
      final cachedFile = await getCachedFirebaseStorageFile(
        widget.pdfUrl,
      );
      setState(() {
        _cachedPdfFile = cachedFile;
      });
    }
  }

  @override
  void initState() {
    _initPdf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_cachedPdfFile != null) {
      return PdfViewer(path: _cachedPdfFile!.path);
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
