import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/cached_pdf_viewer.dart';
import '../../../domain/entities/asset.dart';

class AssetDocumentsTab extends StatelessWidget {
  const AssetDocumentsTab({
    Key? key,
    required this.asset,
  }) : super(key: key);

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: asset.documents.length,
      itemBuilder: (context, index) => AspectRatio(
        aspectRatio: 2 / 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: CachedPdfViewer(
            pdfUrl: asset.documents[index],
          ),
        ),
      ),
    );
  }
}
