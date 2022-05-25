import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/utils/responsive_size.dart';
import 'package:under_control_v2/features/core/utils/size_config.dart';

import '../blocs/company_management/company_management_bloc.dart';

class CompaniesList extends StatelessWidget with ResponsiveSize {
  const CompaniesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocConsumer<CompanyManagementBloc, CompanyManagementState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        // data loaded
        switch (state.runtimeType) {
          case CompanyManagementCompaniesLoaded:
            return Stack(
              children: [
                ListView.builder(
                  itemCount: (state as CompanyManagementCompaniesLoaded)
                      .companies
                      .allCompanies
                      .length,
                  itemBuilder: (context, index) {
                    final companylist = state.companies.allCompanies;
                    // list item
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: responsiveSizePx(small: 3, medium: 6),
                        horizontal: 8.0,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            responsiveSizePx(small: 15, medium: 30)),
                        child: Container(
                          color: Theme.of(context).splashColor,
                          child: Row(
                            children: <Widget>[
                              // company logo
                              SizedBox(
                                width:
                                    responsiveSizePx(small: 120, medium: 100),
                                height:
                                    responsiveSizePx(small: 120, medium: 100),
                                child: companylist[index].logo == ''
                                    ? const Icon(Icons.build)
                                    : FadeInImage.assetNetwork(
                                        fit: BoxFit.cover,
                                        placeholder:
                                            'assets/undercontrol-adaptive.png',
                                        image: companylist[index].logo,
                                      ),
                              ),
                              SizedBox(
                                width: responsiveSizePx(small: 8, medium: 16),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // company name
                                    Text(
                                      companylist[index].name,
                                      style: TextStyle(
                                        fontSize: responsiveSizePx(
                                            small: 16, medium: 30),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    SizedBox(
                                      height:
                                          responsiveSizePx(small: 4, medium: 8),
                                    ),
                                    // country
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: responsiveSizePx(
                                                  small: 15, medium: 30),
                                            ),
                                            Text(
                                              companylist[index].country,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color:
                                                    Theme.of(context).hintColor,
                                                fontSize: responsiveSizePx(
                                                    small: 14, medium: 22),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // city
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.handyman,
                                              color:
                                                  Theme.of(context).hintColor,
                                              size: responsiveSizePx(
                                                  small: 15, medium: 30),
                                            ),
                                            Text(
                                              companylist[index].city,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color:
                                                    Theme.of(context).hintColor,
                                                fontSize: responsiveSizePx(
                                                    small: 14, medium: 22),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // address
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.handyman,
                                              color:
                                                  Theme.of(context).hintColor,
                                              size: responsiveSizePx(
                                                  small: 15, medium: 30),
                                            ),
                                            Text(
                                              companylist[index].address,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color:
                                                    Theme.of(context).hintColor,
                                                fontSize: responsiveSizePx(
                                                    small: 14, medium: 22),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),

                              const SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );

                    // Card(
                    //   child: ListTile(
                    //     leading: SizedBox(
                    //       height: 50,
                    //       width: 50,
                    //       child: companylist[index].logo == ''
                    //           ? Icon(Icons.build)
                    //           : FadeInImage.assetNetwork(
                    //               placeholder:
                    //                   'assets/undercontrol-adaptive.png',
                    //               image: companylist[index].logo,
                    //             ),
                    //     ),
                    //     title: Text(companylist[index].name),
                    //   ),
                    // );
                  },
                ),
                Positioned(
                  bottom: 12,
                  right: 8,
                  child: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          case CompanyManagementLoading:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(
                  height: 16,
                ),
                Text(AppLocalizations.of(context)!.assign_company_list_loading),
              ],
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
