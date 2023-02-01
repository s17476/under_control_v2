import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/presentation/widgets/cached_pdf_viewer.dart';
import '../../../domain/entities/item.dart';

class ItemDocumentsTab extends StatelessWidget {
  const ItemDocumentsTab({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    if (item.documents.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: item.documents.length,
        itemBuilder: (context, index) => AspectRatio(
          aspectRatio: 2 / 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: CachedPdfViewer(
              pdfUrl: item.documents[index],
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
