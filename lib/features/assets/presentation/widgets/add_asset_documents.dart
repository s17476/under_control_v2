import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/presentation/widgets/pdf_viewer.dart';
import '../../../core/utils/responsive_size.dart';

class AddAssetDocumentsCard extends StatelessWidget with ResponsiveSize {
  const AddAssetDocumentsCard({
    Key? key,
    required this.addDocument,
    required this.removeDocument,
    required this.documents,
  }) : super(key: key);

  final Function(File) addDocument;
  final Function(File) removeDocument;
  final List<File> documents;

  void _pickPdfFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      addDocument(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                // title
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    left: 8,
                    right: 8,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.asset_add_documents,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: documents
                          .map(
                            (doc) => PdfViewer(path: doc.path),
                          )
                          .toList(),
                    ),
                  ),
                ),

                // pick pfd
                if (documents.length < 10)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                      ),
                      onPressed: () => _pickPdfFile(context),
                      icon: const FaIcon(FontAwesomeIcons.filePdf),
                      label: Text(
                        AppLocalizations.of(context)!.asset_add_pdf,
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
