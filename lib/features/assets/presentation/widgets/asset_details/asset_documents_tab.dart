import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    if (asset.documents.isNotEmpty) {
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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            FontAwesomeIcons.filePdf,
            size: 70,
            color: Theme.of(context).textTheme.bodySmall!.color!,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            AppLocalizations.of(context)!.details_no_documents,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
