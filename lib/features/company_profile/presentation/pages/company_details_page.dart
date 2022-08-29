import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'package:under_control_v2/features/company_profile/presentation/widgets/edit_company_modal_bottom_sheet.dart';
import 'package:under_control_v2/features/core/presentation/widgets/icon_title_row.dart';
import 'package:under_control_v2/features/core/presentation/widgets/loading_widget.dart';
import 'package:under_control_v2/features/core/utils/choice.dart';
import 'package:under_control_v2/features/core/utils/responsive_size.dart';
import 'package:under_control_v2/features/core/utils/size_config.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

import '../../../core/presentation/widgets/cached_user_avatar.dart';
import '../../../core/presentation/widgets/url_launcher_helpers.dart';
import '../../../user_profile/domain/entities/user_profile.dart';

class CompanyDetailsPage extends StatefulWidget {
  const CompanyDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/company/details';

  @override
  State<CompanyDetailsPage> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetailsPage>
    with ResponsiveSize {
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
        onTap: () => showEditCompanyModalBottomSheet(
          context: context,
          company: company,
        ),
      ),
      Choice(
        title: AppLocalizations.of(context)!.company_details_edit_logo,
        icon: Icons.image,
        // TODO
        onTap: () => print('image'),
      ),
    ];

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            CachedUserAvatar(
                              size: responsiveSizePct(small: 30),
                              imageUrl: company.logo,
                              isCircular: false,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                company.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(thickness: 1.5),
                        // contact data
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            left: 8,
                            right: 8,
                          ),
                          child: Column(
                            children: [
                              IconTitleRow(
                                icon: Icons.info,
                                iconColor: Colors.grey.shade300,
                                iconBackground: Colors.black,
                                title: AppLocalizations.of(context)!
                                    .company_details_contact,
                                titleFontSize: 16,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              // phone number
                              InkWell(
                                onTap: () => makePhoneCall(company.phoneNumber),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.call,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .add_company_intro_card_phone_number,
                                        ),
                                      ),
                                      Text(company.phoneNumber),
                                    ],
                                  ),
                                ),
                              ),
                              // mail
                              InkWell(
                                onTap: () => mailTo(company.email),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.email,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .add_company_intro_card_email,
                                        ),
                                      ),
                                      Text(
                                        company.email,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // homepage
                              InkWell(
                                onTap: () => openInBrowser(company.homepage),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.web,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .add_company_intro_card_homepage,
                                        ),
                                      ),
                                      Text(
                                        company.homepage,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1.5,
                        ),
                        // company data
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            left: 8,
                            right: 8,
                          ),
                          child: Column(
                            children: [
                              IconTitleRow(
                                icon: Icons.factory,
                                iconColor: Colors.grey.shade300,
                                iconBackground: Colors.black,
                                title: AppLocalizations.of(context)!
                                    .company_details_data,
                                titleFontSize: 16,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              // vat
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.numbers,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .add_company_intro_card_vat_number,
                                      ),
                                    ),
                                    Text(company.vatNumber),
                                  ],
                                ),
                              ),
                              // address
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.home,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .add_company_intro_card_address,
                                      ),
                                    ),
                                    Text(company.address),
                                  ],
                                ),
                              ),
                              // post code
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.local_post_office,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .add_company_intro_card_postcode,
                                      ),
                                    ),
                                    Text(company.postCode),
                                  ],
                                ),
                              ),
                              // city
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_city,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .add_company_intro_card_city,
                                      ),
                                    ),
                                    Text(company.city),
                                  ],
                                ),
                              ),
                              // country
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.flag,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .add_company_intro_card_country,
                                      ),
                                    ),
                                    Text(company.country),
                                  ],
                                ),
                              ),
                              // join date
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .company_details_join_date,
                                      ),
                                    ),
                                    Text(
                                      DateFormat('dd/MM/yyyy')
                                          .format(company.joinDate),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
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
