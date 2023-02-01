import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/presentation/widgets/pdf_viewer.dart';
import '../../../../core/utils/responsive_size.dart';

class AddAssetDocumentsCard extends StatelessWidget with ResponsiveSize {
  const AddAssetDocumentsCard({
    Key? key,
    required this.addDocument,
    required this.removeDocument,
    required this.documents,
    required this.loading,
  }) : super(key: key);

  final Function(File) addDocument;
  final Function(File) removeDocument;
  final List<File> documents;
  final bool loading;

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
    // loading images - edit mode
    if (loading) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            crossAxisCount: 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              for (int i = 0; i < 16; i++)
                SizedBox.expand(
                  child: Shimmer.fromColors(
                    baseColor: Theme.of(context).cardColor,
                    highlightColor: Theme.of(context).cardColor.withAlpha(60),
                    child: Container(color: Colors.black),
                  ),
                )
            ],
          ),
        ),
      );
    }
    return Stack(
      children: [
        SafeArea(
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
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .fontSize,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: documents.length + 1,
                          itemBuilder: (context, index) {
                            if (index == documents.length) {
                              return const SizedBox(height: 100);
                            }
                            return Stack(
                              key: ValueKey(documents[index].path),
                              children: [
                                AspectRatio(
                                  aspectRatio: 2 / 3,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 16,
                                    ),
                                    child:
                                        PdfViewer(path: documents[index].path),
                                  ),
                                ),
                                Positioned(
                                  top: 16,
                                  left: 16,
                                  child: IconButton(
                                    onPressed: () =>
                                        removeDocument(documents[index]),
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 30,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black,
                                          blurRadius: 25,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 58,
          right: 16,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.blue.shade700,
            onPressed: () => _pickPdfFile(context),
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const FaIcon(
                  FontAwesomeIcons.filePdf,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  AppLocalizations.of(context)!.asset_add_pdf,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
