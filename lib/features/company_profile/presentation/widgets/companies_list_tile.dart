import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../domain/entities/company.dart';

class CompaniesListTile extends StatelessWidget {
  const CompaniesListTile({
    Key? key,
    required this.company,
  }) : super(key: key);

  final Company company;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).unfocus();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Text(
              AppLocalizations.of(context)!
                  .assign_company_list_confirm_dialog_title,
            ),
            content: Text(
              AppLocalizations.of(context)!
                  .assign_company_list_confirm_dialog_text(company.name),
            ),
            actions: [
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.displayLarge!.color),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.confirm),
                onPressed: () {
                  final userProfileBloc = context.read<UserProfileBloc>();
                  userProfileBloc.add(
                    AssignToCompanyEvent(
                      userProfile:
                          (userProfileBloc.state as NoCompanyState).userProfile,
                      companyId: company.id,
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              // company logo
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: company.logo == ''
                      ? Image.asset('assets/undercontrol-adaptive.png')
                      : FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: 'assets/uc-loading.gif',
                          image: company.logo,
                        ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // company name
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        company.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // country
                    Wrap(
                      direction: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? Axis.horizontal
                          : Axis.vertical,
                      spacing: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? 15
                          : 0,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Theme.of(context).hintColor,
                            ),
                            Text(
                              company.country,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        // city
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_city,
                              color: Theme.of(context).hintColor,
                              size: 16,
                            ),
                            Text(
                              company.city,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        // address
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.store_mall_directory,
                              color: Theme.of(context).hintColor,
                              size: 16,
                            ),
                            Text(
                              company.address,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).hintColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
