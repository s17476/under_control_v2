import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/presentation/widgets/image_viewer.dart';
import '../../../../core/presentation/widgets/pdf_viewer.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../knowledge_base/presentation/blocs/instruction/instruction_bloc.dart';
import '../../../../knowledge_base/presentation/widgets/instruction_selection/overlay_instruction_selection.dart';
import '../../../../knowledge_base/presentation/widgets/instruction_tile.dart';
import '../../../../knowledge_base/presentation/widgets/shimmer_instruction_tile.dart';
import 'add_item_overlay_menu.dart';

class AddItemAdditional extends StatelessWidget with ResponsiveSize {
  const AddItemAdditional({
    Key? key,
    required this.addImage,
    required this.removeImage,
    required this.addDocument,
    required this.removeDocument,
    required this.toggleInstructionSelection,
    required this.toggleAddInstructionsVisibility,
    required this.toggleAddAdditionalVisibility,
    required this.itemImage,
    required this.itemImageUrl,
    required this.documents,
    required this.instructions,
    required this.isAddInstructionsVisible,
    required this.isAddAdditionalVisible,
    required this.loadingDocuments,
  }) : super(key: key);

  final Function(ImageSource) addImage;
  final Function() removeImage;
  final Function(File) addDocument;
  final Function(File) removeDocument;
  final Function(String) toggleInstructionSelection;
  final Function() toggleAddInstructionsVisibility;
  final Function() toggleAddAdditionalVisibility;
  final File? itemImage;
  final String? itemImageUrl;
  final List<File> documents;
  final List<String> instructions;
  final bool isAddInstructionsVisible;
  final bool isAddAdditionalVisible;

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

  List<SpeedDialChild> _addAssetsOverlayMenuItems(BuildContext context) {
    final List<SpeedDialChild> choices = [
      // camera
      SpeedDialChild(
        label: AppLocalizations.of(context)!.take_photo,
        child: const Icon(Icons.camera),
        onTap: () {
          addImage(ImageSource.camera);
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
          addImage(ImageSource.gallery);
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
                                // image
                                if (itemImage != null ||
                                    (itemImageUrl != null &&
                                        itemImageUrl!.isNotEmpty)) ...[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .content_image,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Stack(
                                        children: [
                                          if (itemImageUrl != null &&
                                              itemImageUrl!.isNotEmpty &&
                                              itemImage == null)
                                            SizedBox(
                                              width:
                                                  responsiveSizePct(small: 100),
                                              height:
                                                  responsiveSizePct(small: 100),
                                              child: CachedNetworkImage(
                                                imageUrl: itemImageUrl!,
                                                placeholder: (context, url) =>
                                                    const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const SizedBox(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          if (itemImage != null) ...[
                                            SizedBox(
                                              width:
                                                  responsiveSizePct(small: 100),
                                              height:
                                                  responsiveSizePct(small: 100),
                                              child: Image.file(
                                                itemImage!,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              left: 0,
                                              child: IconButton(
                                                onPressed: () => removeImage(),
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
                                        ],
                                      ),
                                    ],
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
                                if (instructions.isNotEmpty) ...[
                                  InstructionsList(
                                    instructions: instructions,
                                    toggleSelection: toggleInstructionSelection,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
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
        //   AddItemOverlayMenu(
        //     onDismiss: toggleAddAdditionalVisibility,
        //     pickImage: addImage,
        //     pickPdfFile: _pickPdfFile,
        //     toggleAddInstructionsVisibility: toggleAddInstructionsVisibility,
        //   ),
        if (isAddInstructionsVisible)
          OverlayInstructionSelection(
            onDismiss: toggleAddInstructionsVisibility,
            instructions: instructions,
            toggleSelection: toggleInstructionSelection,
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
