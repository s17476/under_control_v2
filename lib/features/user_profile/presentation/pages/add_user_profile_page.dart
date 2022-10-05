import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/utils/show_snack_bar.dart';
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
  final _firstNameTexEditingController = TextEditingController();
  final _lastNameTexEditingController = TextEditingController();
  final _phoneNumberTexEditingController = TextEditingController();
  final _pageController = PageController();

  File? _userAvatar;

  List<Widget> _pages = [];

  void _addUser() {
    final userProfile = UserProfileModel.newUser(
      firstName: _firstNameTexEditingController.text.trim(),
      lastName: _lastNameTexEditingController.text.trim(),
      phoneNumber: _phoneNumberTexEditingController.text.trim(),
    );

    context.read<UserProfileBloc>().add(
          AddUserEvent(
            userProfile: userProfile,
            avatar: _userAvatar,
          ),
        );
  }

  void _setAvatar(ImageSource souruce) async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(
        source: souruce,
        imageQuality: 100,
        maxHeight: 2000,
        maxWidth: 2000,
      );
      if (pickedFile != null) {
        setState(() {
          _userAvatar = File(pickedFile.path);
        });
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
  void dispose() {
    _firstNameTexEditingController.dispose();
    _lastNameTexEditingController.dispose();
    _phoneNumberTexEditingController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      WelcomeCard(pageController: _pageController),
      PersonalDataCard(
        pageController: _pageController,
        firstNameTexEditingController: _firstNameTexEditingController,
        lastNameTexEditingController: _lastNameTexEditingController,
        phoneNumberTexEditingController: _phoneNumberTexEditingController,
      ),
      AvatarCard(
        pageController: _pageController,
        setAvatar: _setAvatar,
        image: _userAvatar,
      ),
      DataCheckCard(
        addUser: _addUser,
        pageController: _pageController,
        firstNameTexEditingController: _firstNameTexEditingController,
        lastNameTexEditingController: _lastNameTexEditingController,
        phoneNumberTexEditingController: _phoneNumberTexEditingController,
        image: _userAvatar,
      )
    ];

    DateTime preBackpress = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        // double click to exit the app
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(
                AppLocalizations.of(context)!.back_to_exit_creator,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              duration: const Duration(seconds: 2),
              backgroundColor: Theme.of(context).errorColor,
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
              controller: _pageController,
              children: _pages,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: _pages.length,
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
