import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company.dart';

import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../data/models/company_model.dart';
import '../blocs/company_management/company_management_bloc.dart';
import '../widgets/add_company_card.dart';

class AddCompanyPage extends StatefulWidget {
  const AddCompanyPage({Key? key}) : super(key: key);

  static const routeName = '/addCompany';

  @override
  State<AddCompanyPage> createState() => _AddCompanyPageState();
}

class _AddCompanyPageState extends State<AddCompanyPage> {
  List<Widget> _pages = [];

  Company? _company;

  final _formKey = GlobalKey<FormState>();

  final _pageController = PageController();
  final _nameTexEditingController = TextEditingController();
  final _addressTexEditingController = TextEditingController();
  final _postCodeTexEditingController = TextEditingController();
  final _cityTexEditingController = TextEditingController();
  final _countryTexEditingController = TextEditingController();
  final _currencyTexEditingController = TextEditingController();
  final _vatNumberTexEditingController = TextEditingController();
  final _phoneNumberTexEditingController = TextEditingController();
  final _emailTexEditingController = TextEditingController();
  final _homepageTexEditingController = TextEditingController();

  void _addNewCompany(BuildContext context) {
    if (_formKey.currentState != null) {
      final isValid = _formKey.currentState!.validate();
      FocusScope.of(context).unfocus();
      if (isValid) {
        final company = CompanyModel(
          id: _company != null ? _company!.id : '',
          name: _nameTexEditingController.text.trim(),
          address: _addressTexEditingController.text.trim(),
          postCode: _postCodeTexEditingController.text.trim(),
          city: _cityTexEditingController.text.trim(),
          country: _countryTexEditingController.text.trim(),
          currency: _currencyTexEditingController.text.trim(),
          vatNumber: _vatNumberTexEditingController.text.trim(),
          phoneNumber: _phoneNumberTexEditingController.text.trim(),
          email: _emailTexEditingController.text.trim(),
          homepage: _homepageTexEditingController.text.trim(),
          logo: _company != null ? _company!.logo : '',
          joinDate: DateTime.now(),
        );

        if (_company == null) {
          context.read<CompanyManagementBloc>().add(
                AddCompanyEvent(
                  company: company,
                  companies: (context.read<CompanyManagementBloc>().state
                          as CompanyManagementCompaniesLoaded)
                      .companies,
                ),
              );
        } else {
          context.read<CompanyManagementBloc>().add(
                UpdateCompanyDataEvent(
                  company: company,
                ),
              );
        }
        Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    _pageController.addListener(() {
      FocusScope.of(context).unfocus();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final data = ModalRoute.of(context)!.settings.arguments;
    if (data is Company) {
      _company = data;
    }
    if (_company != null) {
      _nameTexEditingController.text = _company!.name;
      _addressTexEditingController.text = _company!.address;
      _postCodeTexEditingController.text = _company!.postCode;
      _cityTexEditingController.text = _company!.city;
      _countryTexEditingController.text = _company!.country;
      _currencyTexEditingController.text = _company!.currency;
      _vatNumberTexEditingController.text = _company!.vatNumber;
      _phoneNumberTexEditingController.text = _company!.phoneNumber;
      _emailTexEditingController.text = _company!.email;
      _homepageTexEditingController.text = _company!.homepage;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameTexEditingController.dispose();
    _addressTexEditingController.dispose();
    _postCodeTexEditingController.dispose();
    _cityTexEditingController.dispose();
    _countryTexEditingController.dispose();
    _currencyTexEditingController.dispose();
    _vatNumberTexEditingController.dispose();
    _phoneNumberTexEditingController.dispose();
    _emailTexEditingController.dispose();
    _homepageTexEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      AddCompanyCard(
        nameTexEditingController: _nameTexEditingController,
        addressTexEditingController: _addressTexEditingController,
        cityTexEditingController: _cityTexEditingController,
        countryTexEditingController: _countryTexEditingController,
        currencyTexEditingController: _currencyTexEditingController,
        postCodeTexEditingController: _postCodeTexEditingController,
        homepageTexEditingController: _homepageTexEditingController,
        emailTexEditingController: _emailTexEditingController,
        phoneNumberTexEditingController: _phoneNumberTexEditingController,
        vatNumberTexEditingController: _vatNumberTexEditingController,
        isEditMode: _company != null,
      ),
    ];
    DateTime preBackpress = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        // double click to exit the app
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          showSnackBar(
            context: context,
            message: AppLocalizations.of(context)!.back_to_exit_creator,
            isErrorMessage: true,
            showExitButton: true,
          );
          return false;
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          return true;
        }
      },
      child: Scaffold(
        body: BlocConsumer<CompanyManagementBloc, CompanyManagementState>(
          listener: (context, state) {
            if (state.error) {
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: state.error
                        ? Theme.of(context).errorColor
                        : Theme.of(context).snackBarTheme.backgroundColor,
                  ),
                );
            } else if (!state.error &&
                state is CompanyManagementCompaniesLoaded &&
                state.selectedCompany != null) {
              context.read<UserProfileBloc>().add(
                    AssignToCompanyEvent(
                      companyId: state.selectedCompany!.id,
                      userProfile: (context.read<UserProfileBloc>().state
                              as NoCompanyState)
                          .userProfile,
                    ),
                  );
            }
          },
          builder: (context, state) {
            if (state is CompanyManagementLoading) {
              return const LoadingPage();
            } else {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Form(
                    key: _formKey,
                    child: PageView(
                      controller: _pageController,
                      children: _pages,
                    ),
                  ),
                  CreatorBottomNavigation(
                    lastPageForwardButtonFunction: () =>
                        _addNewCompany(context),
                    pages: _pages,
                    pageController: _pageController,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
