import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:under_control_v2/features/core/presentation/pages/loading_page.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

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
  List<Widget> pages = [];

  final _formKey = GlobalKey<FormState>();

  final pageController = PageController();
  final nameTexEditingController = TextEditingController();
  final addressTexEditingController = TextEditingController();
  final postCodeTexEditingController = TextEditingController();
  final cityTexEditingController = TextEditingController();
  final countryTexEditingController = TextEditingController();
  final vatNumberTexEditingController = TextEditingController();
  final phoneNumberTexEditingController = TextEditingController();
  final emailTexEditingController = TextEditingController();
  final homepageTexEditingController = TextEditingController();

  void addNewCompany(BuildContext context) {
    if (_formKey.currentState != null) {
      final isValid = _formKey.currentState!.validate();
      FocusScope.of(context).unfocus();
      if (isValid) {
        final company = CompanyModel(
          id: '',
          name: nameTexEditingController.text.trim(),
          address: addressTexEditingController.text.trim(),
          postCode: postCodeTexEditingController.text.trim(),
          city: cityTexEditingController.text.trim(),
          country: countryTexEditingController.text.trim(),
          vatNumber: vatNumberTexEditingController.text.trim(),
          phoneNumber: phoneNumberTexEditingController.text.trim(),
          email: emailTexEditingController.text.trim(),
          homepage: homepageTexEditingController.text.trim(),
          logo: '',
          joinDate: DateTime.now(),
        );

        context.read<CompanyManagementBloc>().add(
              AddCompanyEvent(
                company: company,
                companies: (context.read<CompanyManagementBloc>().state
                        as CompanyManagementCompaniesLoaded)
                    .companies,
              ),
            );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      AddCompanyCard(
        nameTexEditingController: nameTexEditingController,
        addressTexEditingController: addressTexEditingController,
        cityTexEditingController: cityTexEditingController,
        countryTexEditingController: countryTexEditingController,
        postCodeTexEditingController: postCodeTexEditingController,
        homepageTexEditingController: homepageTexEditingController,
        emailTexEditingController: emailTexEditingController,
        phoneNumberTexEditingController: phoneNumberTexEditingController,
        vatNumberTexEditingController: vatNumberTexEditingController,
        addNewCompany: addNewCompany,
        pageController: pageController,
      ),
    ];
    return Scaffold(
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
                    userProfile:
                        (context.read<UserProfileBloc>().state as NoCompany)
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
                    controller: pageController,
                    children: pages,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
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
            );
          }
        },
      ),
    );
  }
}
