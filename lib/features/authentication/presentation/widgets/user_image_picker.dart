import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:under_control_v2/features/core/utils/responsive_size.dart';
import 'package:under_control_v2/features/core/utils/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//helper to pick images from camera and device storage
class UserImagePicker extends StatefulWidget {
  const UserImagePicker(
      {Key? key, required this.imagePickFn, required this.image})
      : super(key: key);

  final File? image;

  final Function(
    File pickedImage,
  ) imagePickFn;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> with ResponsiveSize {
  @override
  void initState() {
    super.initState();
    _image = widget.image;
  }

  File? _image;

  void _pickImage(ImageSource souruce) async {
    final picker = ImagePicker();

    try {
      //gets low quality avatar image to improve loading speed
      final pickedFile = await picker.pickImage(
        source: souruce,
        imageQuality: 80,
        maxHeight: 300,
        maxWidth: 300,
      );
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        widget.imagePickFn(_image!);
      }
    } catch (e) {
      _image = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Column(
      children: [
        CircleAvatar(
          radius: responsiveSizePx(small: 60, medium: 60),
          backgroundColor: Colors.grey,
          backgroundImage: _image != null ? FileImage(_image!) : null,
          child: _image == null
              ? Text(
                  '?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: responsiveSizePx(small: 50, medium: 100),
                    fontWeight: FontWeight.w700,
                  ),
                )
              : null,
        ),
        Row(
          mainAxisAlignment: isSmallScreen()
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.center,
          children: [
            //take foto
            TextButton.icon(
              onPressed: () {
                _pickImage(ImageSource.camera);
              },
              icon: const Icon(
                Icons.camera,
                size: 20,
              ),
              label: Text(
                AppLocalizations.of(context)!.take_photo,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),

            //choose avatar image from device
            TextButton.icon(
              onPressed: () {
                _pickImage(ImageSource.gallery);
              },
              icon: const Icon(
                Icons.image,
                size: 20,
              ),
              label: Text(
                AppLocalizations.of(context)!.choose_image,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
