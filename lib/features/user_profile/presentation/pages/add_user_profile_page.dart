import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../data/models/user_profile_model.dart';
import '../blocs/user_profile/user_profile_bloc.dart';
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
  final firstNameTexEditingController = TextEditingController();
  final lastNameTexEditingController = TextEditingController();
  final phoneNumberTexEditingController = TextEditingController();
  final pageController = PageController();

  File? userAvatar;

  List<Widget> pages = [];

  void addUser() {
    final userProfile = UserProfileModel.newUser(
      firstName: firstNameTexEditingController.text.trim(),
      lastName: lastNameTexEditingController.text.trim(),
      phoneNumber: phoneNumberTexEditingController.text.trim(),
    );

    context.read<UserProfileBloc>().add(
          AddUserEvent(
            userProfile: userProfile,
            avatar: userAvatar,
          ),
        );
  }

  void setAvatar(ImageSource souruce) async {
    final picker = ImagePicker();

    try {
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
  Widget build(BuildContext context) {
    DateTime preBackpress = DateTime.now();
    pages = [
      WelcomeCard(pageController: pageController),
      PersonalDataCard(
        pageController: pageController,
        firstNameTexEditingController: firstNameTexEditingController,
        lastNameTexEditingController: lastNameTexEditingController,
        phoneNumberTexEditingController: phoneNumberTexEditingController,
      ),
      AvatarCard(
        pageController: pageController,
        setAvatar: setAvatar,
        image: userAvatar,
      ),
      DataCheckCard(
        addUser: addUser,
        pageController: pageController,
        firstNameTexEditingController: firstNameTexEditingController,
        lastNameTexEditingController: lastNameTexEditingController,
        phoneNumberTexEditingController: phoneNumberTexEditingController,
        image: userAvatar,
      )
    ];
    return WillPopScope(
      // double click to exit the app
      onWillPop: () async {
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(
                AppLocalizations.of(context)!.back_to_exit,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.black,
            ));
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: pageController,
              children: pages,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: SmoothPageIndicator(
                controller: pageController,
                count: pages.length,
                effect: JumpingDotEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  jumpScale: 2,
                  activeDotColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
