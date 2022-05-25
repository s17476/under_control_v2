import 'package:flutter/material.dart';

import 'package:under_control_v2/features/core/utils/responsive_size.dart';

import '../../domain/entities/company.dart';

class CompaniesListTile extends StatelessWidget with ResponsiveSize {
  const CompaniesListTile({
    Key? key,
    required this.company,
  }) : super(key: key);

  final Company company;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('object'),
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
                  child: company.logo == ''
                      ? const Icon(Icons.build)
                      : FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: 'assets/uc-loading.gif',
                          image: company.logo,
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
