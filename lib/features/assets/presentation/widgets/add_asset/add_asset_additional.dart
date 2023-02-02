import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:under_control_v2/features/assets/presentation/widgets/add_asset/add_assets_overlay_menu.dart';

import '../../../../core/presentation/widgets/image_viewer.dart';
import '../../../../core/presentation/widgets/pdf_viewer.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../../inventory/presentation/widgets/inventory_selection/overlay_inventory_selection.dart';
import '../../../../inventory/presentation/widgets/inventory_spare_parts_list.dart';
import '../../../../knowledge_base/presentation/widgets/instruction_selection/overlay_instruction_selection.dart';
import '../asset_selection/overlay_asset_selection.dart';
import '../assets_spare_parts_list.dart';

class AddAssetAdditional extends StatelessWidget {
  const AddAssetAdditional({
    Key? key,
    required this.addImage,
    required this.removeImage,
    required this.addDocument,
    required this.removeDocument,
    required this.toggleInstructionSelection,
    required this.toggleSparePartSelection,
    required this.toggleAddAssetVisibility,
    required this.toggleAddInventoryVisibility,
    required this.toggleAddInstructionsVisibility,
    required this.toggleAddAdditionalVisibility,
    required this.images,
    required this.documents,
    required this.spareParts,
    required this.instructions,
    required this.isAddAssetVisible,
    required this.isAddInventoryVisible,
    required this.isAddInstructionsVisible,
    required this.isAddAdditionalVisible,
    required this.loadingImages,
    required this.loadingDocuments,
  }) : super(key: key);

  final Function(File) addImage;
  final Function(File) removeImage;
  final Function(File) addDocument;
  final Function(File) removeDocument;
  final Function(String) toggleInstructionSelection;
  final Function(String) toggleSparePartSelection;
  final Function() toggleAddAssetVisibility;
  final Function() toggleAddInventoryVisibility;
  final Function() toggleAddInstructionsVisibility;
  final Function() toggleAddAdditionalVisibility;
  final List<File> images;
  final List<File> documents;
  final List<String> spareParts;
  final List<String> instructions;
  final bool isAddAssetVisible;
  final bool isAddInventoryVisible;
  final bool isAddInstructionsVisible;
  final bool isAddAdditionalVisible;
  final bool loadingImages;
  final bool loadingDocuments;

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

  void _pickImage(BuildContext context, ImageSource souruce) async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(
        source: souruce,
        imageQuality: 100,
        maxHeight: 2000,
        maxWidth: 2000,
      );
      if (pickedFile != null) {
        addImage(File(pickedFile.path));
      }
    } catch (e) {
      showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!
            .user_profile_add_user_image_pisker_error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        AppLocalizations.of(context)!.additional,
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // images
                            ImagesGrigViev(
                              images: images,
                              removeImage: removeImage,
                            ),
                            // documents
                            DocumentsList(
                              documents: documents,
                              removeDocument: removeDocument,
                            ),
                            // assets
                            AssetsSparePartsList(
                              items: spareParts,
                              onSelected: toggleSparePartSelection,
                            ),
                            // inventory
                            InventorySparePartsList(
                              items: spareParts,
                              onSelected: toggleSparePartSelection,
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                          ],
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
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: toggleAddAdditionalVisibility,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ),
        if (isAddAssetVisible)
          OverlayAssetSelection(
            spareParts: spareParts,
            toggleSelection: toggleSparePartSelection,
            onDismiss: toggleAddAssetVisibility,
          ),
        if (isAddInventoryVisible)
          OverlayInventorySelection(
            spareParts: spareParts,
            toggleSelection: toggleSparePartSelection,
            onDismiss: toggleAddInventoryVisibility,
          ),
        if (isAddAdditionalVisible)
          AddAssetOverlayMenu(
            onDismiss: toggleAddAdditionalVisibility,
            pickImage: _pickImage,
            pickPdfFile: _pickPdfFile,
            toggleAddAssetVisibility: toggleAddAssetVisibility,
            toggleAddInstructionsVisibility: toggleAddInstructionsVisibility,
            toggleAddInventoryVisibility: toggleAddInventoryVisibility,
          ),
        if (isAddInstructionsVisible)
          OverlayInstructionSelection(
            onDismiss: toggleAddInstructionsVisibility,
            instructions: instructions,
            toggleSelection: toggleInstructionSelection,
          ),
        if (isAddAssetVisible)
          OverlayAssetSelection(
            spareParts: spareParts,
            toggleSelection: toggleSparePartSelection,
            onDismiss: toggleAddAssetVisibility,
          ),
        if (isAddInventoryVisible)
          OverlayInventorySelection(
            spareParts: spareParts,
            toggleSelection: toggleSparePartSelection,
            onDismiss: toggleAddInventoryVisibility,
          ),
      ],
    );
  }
}

class DocumentsList extends StatelessWidget {
  const DocumentsList({
    super.key,
    required this.documents,
    required this.removeDocument,
  });

  final List<File> documents;
  final Function(File p1) removeDocument;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  child: PdfViewer(path: documents[index].path),
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: IconButton(
                  onPressed: () => removeDocument(documents[index]),
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
    );
  }
}

class ImagesGrigViev extends StatelessWidget {
  const ImagesGrigViev({
    super.key,
    required this.images,
    required this.removeImage,
  });

  final List<File> images;
  final Function(File p1) removeImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: images
            .map(
              (img) => InkWell(
                key: ValueKey(img.path),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageViewer(
                        imageProvider: FileImage(img),
                        title: '',
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: img.path,
                  child: Stack(
                    children: [
                      SizedBox.expand(
                        child: Image.file(
                          img,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: IconButton(
                          onPressed: () => removeImage(img),
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
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
