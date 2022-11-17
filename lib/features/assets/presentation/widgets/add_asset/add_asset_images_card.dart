import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/presentation/widgets/image_viewer.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../core/utils/show_snack_bar.dart';

class AddAssetImagesCard extends StatelessWidget with ResponsiveSize {
  const AddAssetImagesCard({
    Key? key,
    required this.addImage,
    required this.removeImage,
    required this.images,
    required this.loading,
  }) : super(key: key);

  final Function(File) addImage;
  final Function(File) removeImage;
  final List<File> images;
  final bool loading;

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
    // loading images - edit mode
    if (loading) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            crossAxisCount: 2,
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
                    AppLocalizations.of(context)!.asset_add_photos,
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
                  ),
                ),
                // take photo
                if (images.length < 10)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () => _pickImage(context, ImageSource.camera),
                      icon: const Icon(Icons.camera),
                      label: Text(
                        AppLocalizations.of(context)!.take_photo,
                      ),
                    ),
                  ),
                // pick from gallery
                if (images.length < 10)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                      ),
                      onPressed: () => _pickImage(context, ImageSource.gallery),
                      icon: const Icon(Icons.photo_size_select_actual_rounded),
                      label: Text(
                        AppLocalizations.of(context)!
                            .user_profile_add_user_personal_data_gallery,
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
