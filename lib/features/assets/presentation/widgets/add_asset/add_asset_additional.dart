import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/presentation/widgets/image_viewer.dart';
import '../../../../core/presentation/widgets/pdf_viewer.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../../inventory/presentation/widgets/inventory_selection/overlay_inventory_selection.dart';
import '../../../../inventory/presentation/widgets/inventory_spare_parts_list.dart';
import '../../../../knowledge_base/presentation/blocs/instruction/instruction_bloc.dart';
import '../../../../knowledge_base/presentation/widgets/instruction_selection/overlay_instruction_selection.dart';
import '../../../../knowledge_base/presentation/widgets/instruction_tile.dart';
import '../../../../knowledge_base/presentation/widgets/shimmer_instruction_tile.dart';
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

  List<SpeedDialChild> _addAssetsOverlayMenuItems(BuildContext context) {
    final List<SpeedDialChild> choices = [
      // camera
      SpeedDialChild(
        label: AppLocalizations.of(context)!.take_photo,
        child: const Icon(Icons.camera),
        onTap: () {
          _pickImage(context, ImageSource.camera);
        },
        shape: const StadiumBorder(),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      // gallery
      SpeedDialChild(
        label: AppLocalizations.of(context)!
            .user_profile_add_user_personal_data_gallery,
        child: const Icon(Icons.photo_size_select_actual_rounded),
        onTap: () {
          _pickImage(context, ImageSource.gallery);
        },
        shape: const StadiumBorder(),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      // pdf
      SpeedDialChild(
        label: AppLocalizations.of(context)!.asset_add_pdf,
        child: const Icon(FontAwesomeIcons.filePdf),
        onTap: () {
          _pickPdfFile(context);
        },
        shape: const StadiumBorder(),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      // instructions
      SpeedDialChild(
        label: AppLocalizations.of(context)!.asset_add_instructions,
        child: const Icon(Icons.menu_book),
        onTap: toggleAddInstructionsVisibility,
        shape: const StadiumBorder(),
        backgroundColor: Colors.purple,
      ),
      // inventory
      SpeedDialChild(
        label: AppLocalizations.of(context)!.bottom_bar_title_inventory,
        child: const Icon(Icons.apps),
        onTap: toggleAddInventoryVisibility,
        shape: const StadiumBorder(),
        backgroundColor: Colors.orange,
      ),
      // assets
      SpeedDialChild(
        label: AppLocalizations.of(context)!.bottom_bar_title_assets,
        child: const Icon(Icons.precision_manufacturing),
        onTap: toggleAddAssetVisibility,
        shape: const StadiumBorder(),
        backgroundColor: Colors.blue,
      ),
    ];
    return choices.reversed.toList();
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            child: Column(
                              children: [
                                // images
                                if (images.isNotEmpty) ...[
                                  ImagesGrigViev(
                                    images: images,
                                    removeImage: removeImage,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                                // documents
                                if (documents.isNotEmpty) ...[
                                  DocumentsList(
                                    documents: documents,
                                    removeDocument: removeDocument,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                                // instructions
                                if (instructions.isNotEmpty) ...[
                                  InstructionsList(
                                    instructions: instructions,
                                    toggleSelection: toggleInstructionSelection,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                                // inventory
                                InventorySparePartsList(
                                  items: spareParts,
                                  onSelected: toggleSparePartSelection,
                                  padding: EdgeInsets.zero,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                // assets
                                AssetsSparePartsList(
                                  items: spareParts,
                                  onSelected: toggleSparePartSelection,
                                  padding: EdgeInsets.zero,
                                ),
                                const SizedBox(
                                  height: 150,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Positioned(
        //   bottom: 58,
        //   right: 16,
        //   child: FloatingActionButton(
        //     backgroundColor: Theme.of(context).primaryColor,
        //     onPressed: toggleAddAdditionalVisibility,
        //     child: const Icon(
        //       Icons.add,
        //       size: 40,
        //     ),
        //   ),
        // ),
        Positioned(
          bottom: 70,
          right: 16,
          child: SpeedDial(
            icon: Icons.add,
            iconTheme: const IconThemeData(size: 36),
            activeIcon: Icons.close,
            overlayOpacity: 0.85,
            spacing: 3,
            childPadding: const EdgeInsets.all(5),
            spaceBetweenChildren: 4,
            backgroundColor: Theme.of(context).primaryColor,
            buttonSize: const Size(50, 50),
            // renderOverlay: true,
            activeBackgroundColor: Colors.black,
            elevation: 8.0,
            animationCurve: Curves.elasticInOut,
            isOpenOnStart: false,
            children: _addAssetsOverlayMenuItems(context),
            childrenButtonSize: const Size(60, 60),
            childMargin: const EdgeInsets.only(right: 0),
            animationDuration: const Duration(milliseconds: 300),
          ),
        ),
        // if (isAddAdditionalVisible)
        //   AddAssetOverlayMenu(
        //     onDismiss: toggleAddAdditionalVisibility,
        //     pickImage: _pickImage,
        //     pickPdfFile: _pickPdfFile,
        //     toggleAddAssetVisibility: toggleAddAssetVisibility,
        //     toggleAddInstructionsVisibility: toggleAddInstructionsVisibility,
        //     toggleAddInventoryVisibility: toggleAddInventoryVisibility,
        //   ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.asset_add_documents_added,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 4,
        ),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          childAspectRatio: 2 / 3,
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: documents
              .map(
                (document) => Stack(
                  alignment: Alignment.center,
                  key: ValueKey(document.path),
                  children: [
                    AspectRatio(
                      aspectRatio: 2 / 3,
                      child: PdfViewer(path: document.path),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: IconButton(
                        onPressed: () => removeDocument(document),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
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
              )
              .toList(),
        ),
      ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.asset_add_images_added,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 4,
        ),
        GridView.count(
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
                              color: Colors.white,
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
      ],
    );
  }
}

class InstructionsList extends StatelessWidget {
  const InstructionsList({
    Key? key,
    required this.instructions,
    required this.toggleSelection,
  }) : super(key: key);

  final List<String> instructions;
  final Function(String) toggleSelection;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstructionBloc, InstructionState>(
      builder: (context, state) {
        if (state is InstructionLoadedState) {
          if (state.allInstructions.allInstructions.isEmpty) {
            return const SizedBox();
          }
          final filteredItems = state.allInstructions.allInstructions
              .where(
                (inst) => instructions.contains(inst.id),
              )
              .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.asset_add_instructions_added,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 4,
              ),
              ListView.builder(
                padding: const EdgeInsets.only(top: 2),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                    ),
                    child: InstructionTile(
                      instruction: filteredItems[index],
                      searchQuery: '',
                      isSelected:
                          instructions.contains(filteredItems[index].id),
                      onSelection: toggleSelection,
                    ),
                  );
                },
              ),
            ],
          );
        } else {
          // loading shimmer animation
          return ListView.builder(
            padding: const EdgeInsets.only(top: 2),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) {
              return const ShimmerInstructionTile();
            },
          );
        }
      },
    );
  }
}
