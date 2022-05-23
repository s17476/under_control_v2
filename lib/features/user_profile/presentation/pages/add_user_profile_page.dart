import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/avatar_card.dart';
import '../widgets/data_check_card.dart';
import '../widgets/personal_data_card.dart';
import '../widgets/welcome_card.dart';

class AddUserProfilePage extends StatefulWidget {
  const AddUserProfilePage({Key? key}) : super(key: key);

  @override
  State<AddUserProfilePage> createState() => _AddUserProfilePageState();
}

class _AddUserProfilePageState extends State<AddUserProfilePage> {
  final pageController = PageController();
  final firstNameTexEditingController = TextEditingController();
  final lastNameTexEditingController = TextEditingController();
  final phoneNumberTexEditingController = TextEditingController();
  final String imageUrl = '';
  File? userAvatar;

  void setAvatar(ImageSource souruce) async {
    final picker = ImagePicker();

    try {
      //gets low quality avatar image to improve loading speed
      final pickedFile = await picker.pickImage(
        source: souruce,
        imageQuality: 100,
        maxHeight: 500,
        maxWidth: 500,
      );
      if (pickedFile != null) {
        setState(() {
          userAvatar = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!
                  .user_profile_add_user_image_pisker_error,
            ),
          ),
        );
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          WelcomeCard(
            pageController: pageController,
          ),
          PersonalDataCard(
            pageController: pageController,
            firstNameTexEditingController: firstNameTexEditingController,
            lastNameTexEditingController: lastNameTexEditingController,
            phoneNumberTexEditingController: phoneNumberTexEditingController,
          ),
          AvatarCard(
            pageController: pageController,
            firstNameTexEditingController: firstNameTexEditingController,
            lastNameTexEditingController: lastNameTexEditingController,
            phoneNumberTexEditingController: phoneNumberTexEditingController,
            setAvatar: setAvatar,
            image: userAvatar,
          ),
          DataCheckCard(
            pageController: pageController,
            firstNameTexEditingController: firstNameTexEditingController,
            lastNameTexEditingController: lastNameTexEditingController,
            phoneNumberTexEditingController: phoneNumberTexEditingController,
            image: userAvatar,
          )
        ],
      ),
    );
  }
}
