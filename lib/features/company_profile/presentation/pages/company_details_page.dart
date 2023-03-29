import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../core/presentation/widgets/cached_user_avatar.dart';
import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/utils/choice.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../core/utils/size_config.dart';
import '../../../core/utils/url_launcher_helpers.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../domain/entities/company.dart';
import '../blocs/company_management/company_management_bloc.dart';
import '../blocs/company_profile/company_profile_bloc.dart';
import '../widgets/logo_editor_card.dart';
import 'add_company_page.dart';

class CompanyDetailsPage extends StatefulWidget {
  const CompanyDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/company/details';

  @override
  State<CompanyDetailsPage> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetailsPage>
    with ResponsiveSize {
  late CompanyProfileState _companyState;
  late UserProfile _currentUser;
  late Company _company;

  bool _isLogoEditorVisible = false;

  List<Choice> _choices = [];

  void _showLogoEditor() {
    setState(() {
      _isLogoEditorVisible = true;
    });
  }

  void _hideLogoEditor() {
    setState(() {
      _isLogoEditorVisible = false;
    });
  }

  @override
  void didChangeDependencies() {
    _currentUser =
        (context.read<UserProfileBloc>().state as Approved).userProfile;
    _companyState = context.watch<CompanyProfileBloc>().state;
    if (_companyState is CompanyProfileLoaded) {
      _company = (_companyState as CompanyProfileLoaded).company;
    }

    _choices = [
      Choice(
        title: AppLocalizations.of(context)!.user_details_edit_data,
        icon: Icons.edit,
        onTap: () => Navigator.pushNamed(
          context,
          AddCompanyPage.routeName,
          arguments: _company,
        ),
      ),
      Choice(
        title: AppLocalizations.of(context)!.company_details_edit_logo,
        icon: Icons.image,
        onTap: () => _showLogoEditor(),
      ),
    ];

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    if (_companyState is CompanyProfileLoaded) {
      return WillPopScope(
        onWillPop: () async {
          if (_isLogoEditorVisible) {
            _hideLogoEditor();
            return false;
          }
          return true;
        },
        child: BlocListener<CompanyManagementBloc, CompanyManagementState>(
          listener: (context, state) {
            if (state is CompanyManagementLoaded) {
              showSnackBar(
                context: context,
                message: AppLocalizations.of(context)!.add_company_msg_updated,
              );
              context.read<CompanyProfileBloc>().add(
                    GetCompanyByIdEvent(
                      id: _company.id,
                    ),
                  );
            } else if (state is CompanyManagementError) {
              showSnackBar(
                context: context,
                message:
                    AppLocalizations.of(context)!.add_company_msg_not_updated,
                isErrorMessage: true,
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.company_details_title,
              ),
              centerTitle: true,
              actions: [
                if (_currentUser.administrator)
                  PopupMenuButton(
                    onSelected: (Choice choice) {
                      if (_isLogoEditorVisible) {
                        _hideLogoEditor();
                      }
                      choice.onTap();
                    },
                    itemBuilder: (BuildContext context) {
                      return _choices.map((Choice choice) {
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
                              if (_company.logo.isNotEmpty)
                                CachedUserAvatar(
                                  size: responsiveSizePct(small: 30),
                                  imageUrl: _company.logo,
                                  isCircular: false,
                                ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  _company.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
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
                                  onTap: () =>
                                      makePhoneCall(_company.phoneNumber),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
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
                                        Text(_company.phoneNumber),
                                      ],
                                    ),
                                  ),
                                ),
                                // mail
                                InkWell(
                                  onTap: () => mailTo(_company.email),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
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
                                          _company.email,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // homepage
                                InkWell(
                                  onTap: () => openInBrowser(_company.homepage),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
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
                                          _company.homepage,
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
                                      Text(_company.vatNumber),
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
                                      Text(_company.address),
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
                                      Text(_company.postCode),
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
                                      Text(_company.city),
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
                                      Text(_company.country),
                                    ],
                                  ),
                                ),
                                // currency
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.attach_money,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .currency,
                                        ),
                                      ),
                                      Text(_company.currency),
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
                                        DateFormat('dd-MM-yyyy')
                                            .format(_company.joinDate),
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
                  ),
                  if (_isLogoEditorVisible)
                    LogoEditorCard(
                      company: _company,
                      onDismiss: _hideLogoEditor,
                    )
                ],
              ),
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
