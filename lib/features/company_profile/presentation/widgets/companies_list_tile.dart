import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:under_control_v2/features/core/utils/responsive_size.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

import '../../domain/entities/company.dart';

class CompaniesListTile extends StatefulWidget {
  const CompaniesListTile({
    Key? key,
    required this.company,
  }) : super(key: key);

  final Company company;

  @override
  State<CompaniesListTile> createState() => _CompaniesListTileState();
}

class _CompaniesListTileState extends State<CompaniesListTile>
    with ResponsiveSize {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: Text(
              AppLocalizations.of(context)!
                  .assign_company_list_confirm_dialog_title,
            ),
            content: Text(
              AppLocalizations.of(context)!
                  .assign_company_list_confirm_dialog_text(widget.company.name),
            ),
            actions: [
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(width: 8),
              TextButton(
                child: Text(AppLocalizations.of(context)!.confirm),
                onPressed: () {
                  final userProfileBloc = context.read<UserProfileBloc>();
                  userProfileBloc.add(
                    AssignToCompanyEvent(
                      userProfile:
                          (userProfileBloc.state as NoCompany).userProfile,
                      companyId: widget.company.id,
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                blurRadius: 8.0,
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
                  width: responsiveSizePx(small: 120, medium: 100),
                  height: responsiveSizePx(small: 120, medium: 100),
                  child: widget.company.logo == ''
                      ? Image.asset('undercontrol.png')
                      : FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: 'assets/uc-loading.gif',
                          image: widget.company.logo,
                        ),
                ),
              ),
              SizedBox(
                width: responsiveSizePx(small: 16, medium: 32),
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
                        widget.company.name,
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
                              widget.company.country,
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
                              widget.company.city,
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
                              widget.company.address,
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
