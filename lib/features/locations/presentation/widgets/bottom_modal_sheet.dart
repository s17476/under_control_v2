import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/models/location_model.dart';
import '../../domain/entities/location.dart';
import '../blocs/bloc/location_bloc.dart';

Future<void> showAddLocationModalBottomSheet({
  required BuildContext context,
  Location? parentLocation,
  Location? currentLocation,
}) {
  final GlobalKey<FormState> _formKey = GlobalKey();
  LocationModel location = LocationModel.initial();
  final String parentNameInitialValue = parentLocation != null
      ? parentLocation.name
      : (currentLocation != null && currentLocation.parentId.isNotEmpty)
          ? (context.read<LocationBloc>().state as LocationLoadedState)
              .allLocations
              .allLocations
              .firstWhere(
                (element) => element.id == currentLocation.parentId,
              )
              .name
          : AppLocalizations.of(context)!.location_management_add_location_none;
  location = location.copyWith(
    parentId: parentLocation != null
        ? parentLocation.id
        : currentLocation != null
            ? currentLocation.parentId
            : '',
  );
  return showModalBottomSheet<void>(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 590,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  bottom: 4,
                ),
                child: Text(
                  AppLocalizations.of(context)!
                      .location_management_add_location,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            AppLocalizations.of(context)!
                                .location_management_add_location_required_fields,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 8,
                          ),
                          child: Column(
                            children: [
                              // parent name
                              TextFormField(
                                key: const ValueKey('parentName'),
                                enabled: false,
                                initialValue: parentNameInitialValue,
                                decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(Icons.location_on_outlined),
                                  floatingLabelStyle: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .color,
                                  ),
                                  labelText: AppLocalizations.of(context)!
                                      .location_management_add_location_parent,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // location name
                              TextFormField(
                                key: const ValueKey('locationName'),
                                keyboardType: TextInputType.name,
                                initialValue: currentLocation?.name,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.location_on),
                                  floatingLabelStyle: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .color,
                                  ),
                                  labelText: AppLocalizations.of(context)!
                                      .location_management_add_location_name,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 2) {
                                    return AppLocalizations.of(context)!
                                        .location_management_add_location_validation_error;
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  location =
                                      location.copyWith(name: value?.trim());
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                            left: 8,
                            top: 4,
                            bottom: 4,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!
                                .location_management_add_location_optional_fields,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 8,
                          ),
                          child: Column(
                            children: [
                              // address
                              TextFormField(
                                key: const ValueKey('address'),
                                keyboardType: TextInputType.streetAddress,
                                initialValue: currentLocation?.address,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.store_mall_directory_sharp,
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .color,
                                  ),
                                  labelText: AppLocalizations.of(context)!
                                      .add_company_intro_card_address,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                ),
                                validator: (value) {
                                  if (value!.isNotEmpty && value.length < 2) {
                                    return AppLocalizations.of(context)!
                                        .location_management_add_location_validation_error;
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  location =
                                      location.copyWith(address: value?.trim());
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // post code
                              TextFormField(
                                key: const ValueKey('postCode'),
                                keyboardType: TextInputType.streetAddress,
                                initialValue: currentLocation?.postCode,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.local_post_office_rounded,
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .color,
                                  ),
                                  labelText: AppLocalizations.of(context)!
                                      .add_company_intro_card_postcode,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                ),
                                validator: (value) {
                                  if (value!.isNotEmpty && value.length < 2) {
                                    return AppLocalizations.of(context)!
                                        .location_management_add_location_validation_error;
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  location = location.copyWith(
                                      postCode: value?.trim());
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // city
                              TextFormField(
                                key: const ValueKey('city'),
                                keyboardType: TextInputType.streetAddress,
                                initialValue: currentLocation?.city,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.location_city),
                                  floatingLabelStyle: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .color,
                                  ),
                                  labelText: AppLocalizations.of(context)!
                                      .add_company_intro_card_city,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                ),
                                validator: (value) {
                                  if (value!.isNotEmpty && value.length < 2) {
                                    return AppLocalizations.of(context)!
                                        .location_management_add_location_validation_error;
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  location =
                                      location.copyWith(city: value?.trim());
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // country
                              TextFormField(
                                key: const ValueKey('country'),
                                keyboardType: TextInputType.name,
                                initialValue: currentLocation?.country,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.flag),
                                  floatingLabelStyle: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .color,
                                  ),
                                  labelText: AppLocalizations.of(context)!
                                      .add_company_intro_card_country,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                ),
                                validator: (value) {
                                  if (value!.isNotEmpty && value.length < 2) {
                                    return AppLocalizations.of(context)!
                                        .location_management_add_location_validation_error;
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  location =
                                      location.copyWith(country: value?.trim());
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Text(
                          AppLocalizations.of(context)!.cancel,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline1!.color,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextButton(
                        child: Text(
                          currentLocation != null
                              ? AppLocalizations.of(context)!.update
                              : AppLocalizations.of(context)!.add,
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState!.save();
                          if (currentLocation != null) {
                            location =
                                location.copyWith(id: currentLocation.id);
                            context.read<LocationBloc>().add(
                                  UpdateLocationEvent(location: location),
                                );
                          } else {
                            context.read<LocationBloc>().add(
                                  AddLocationEvent(location: location),
                                );
                          }

                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
