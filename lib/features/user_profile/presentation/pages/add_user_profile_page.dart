import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/presentation/widgets/bottom_navigation.dart';
import '../../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../blocs/user_profile/user_profile_bloc.dart';
import '../../data/models/user_profile_model.dart';
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
  final Key formKey = GlobalKey<FormState>();
  final pageController = PageController();
  final firstNameTexEditingController = TextEditingController();
  final lastNameTexEditingController = TextEditingController();
  final phoneNumberTexEditingController = TextEditingController();

  File? userAvatar;

  List<Widget> pages = [];

  void addUser() {
    final userProfile = UserProfileModel.newUser(
      firstName: firstNameTexEditingController.text,
      lastName: lastNameTexEditingController.text,
      phoneNumber: phoneNumberTexEditingController.text,
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
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      const WelcomeCard(),
      PersonalDataCard(
        firstNameTexEditingController: firstNameTexEditingController,
        lastNameTexEditingController: lastNameTexEditingController,
        phoneNumberTexEditingController: phoneNumberTexEditingController,
      ),
      AvatarCard(
        setAvatar: setAvatar,
        image: userAvatar,
      ),
      DataCheckCard(
        firstNameTexEditingController: firstNameTexEditingController,
        lastNameTexEditingController: lastNameTexEditingController,
        phoneNumberTexEditingController: phoneNumberTexEditingController,
        image: userAvatar,
      )
    ];
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: pages,
            ),
          ),
          BottomNavigation(
            pageController: pageController,
            collectionLenght: pages.length,
            firstPageBackwardButtonFunction: () =>
                context.read<AuthenticationBloc>().add(SignoutEvent()),
            firstPageBackwardButtonLabel:
                AppLocalizations.of(context)!.user_profile_add_user_signout,
            firstPageBackwardButtonIconData: Icons.logout,
            firstPageBackwardButtonColor: Colors.black,
            lastPageForwardButtonFunction: addUser,
            lastPageForwardButtonLabel: AppLocalizations.of(context)!
                .user_profile_add_user_personal_data_save,
            lastPageForwardButtonIconData: Icons.check,
            lastPageForwardButtonColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
