import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'package:under_control_v2/features/core/presentation/widgets/loading_widget.dart';
import 'package:under_control_v2/features/core/utils/choice.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

import '../../../user_profile/domain/entities/user_profile.dart';

class CompanyDetailsPage extends StatefulWidget {
  const CompanyDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/company/details';

  @override
  State<CompanyDetailsPage> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetailsPage> {
  late CompanyProfileState companyState;
  late UserProfile currentUser;
  late Company company;

  bool isLogoEditorVisible = false;

  List<Choice> choices = [];

  void showLogoEditor() {
    setState(() {
      isLogoEditorVisible = true;
    });
  }

  void hideLogoEditor() {
    setState(() {
      isLogoEditorVisible = false;
    });
  }

  @override
  void didChangeDependencies() {
    currentUser =
        (context.read<UserProfileBloc>().state as Approved).userProfile;
    companyState = context.watch<CompanyProfileBloc>().state;
    company = (companyState as CompanyProfileLoaded).company;

    choices = [
      Choice(
        title: AppLocalizations.of(context)!.user_details_edit_data,
        icon: Icons.edit,
        onTap: () => print('object'),
      ),
      Choice(
        title: AppLocalizations.of(context)!.company_details_edit_logo,
        icon: Icons.image,
        onTap: () => print('image'),
      ),
    ];

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (companyState is CompanyProfileLoaded) {
      return WillPopScope(
        onWillPop: () async {
          if (isLogoEditorVisible) {
            hideLogoEditor();
            return false;
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.company_details_title,
            ),
            centerTitle: true,
            actions: [
              if (currentUser.administrator)
                PopupMenuButton(
                  onSelected: (Choice choice) {
                    if (isLogoEditorVisible) {
                      hideLogoEditor();
                    }
                    choice.onTap();
                  },
                  itemBuilder: (BuildContext context) {
                    return choices.map((Choice choice) {
                      return PopupMenuItem<Choice>(
                        value: choice,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(choice.icon),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              choice.title,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    }).toList();
                  },
                ),
            ],
          ),
          body: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        //
                        //
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: LoadingWidget(),
      );
    }
  }
}
