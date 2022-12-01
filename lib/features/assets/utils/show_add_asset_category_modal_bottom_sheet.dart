import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/presentation/widgets/custom_text_form_field.dart';
import '../data/models/asset_category/asset_category_model.dart';
import '../presentation/blocs/asset_category/asset_category_bloc.dart';
import '../presentation/blocs/asset_category_management/asset_category_management_bloc.dart';

Future<void> showAddAssetCategoryModalBottomSheet({
  required BuildContext context,
  AssetCategoryModel? assetCategory,
}) {
  final GlobalKey<FormState> formKey = GlobalKey();

  AssetCategoryModel assetCategoryModel =
      assetCategory ?? const AssetCategoryModel(id: '', name: '');
  FocusScope.of(context).unfocus();
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
          height: 210,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  bottom: 4,
                ),
                child: Text(
                  assetCategory == null
                      ? AppLocalizations.of(context)!.item_category_add_new
                      : AppLocalizations.of(context)!.item_category_edit,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Column(
                            children: [
                              // name
                              CustomTextFormField(
                                autofocus: true,
                                fieldKey: 'name',
                                labelText: AppLocalizations.of(context)!
                                    .instruction_category,
                                textCapitalization: TextCapitalization.words,
                                initialValue: assetCategoryModel.name,
                                prefixIcon: const Icon(Icons.category),
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 2) {
                                    return AppLocalizations.of(context)!
                                        .validation_min_two_characters;
                                  }
                                  // chesck if category with choosen name aleready exists
                                  final isCategoryExists = (context
                                          .read<AssetCategoryBloc>()
                                          .state as AssetCategoryLoadedState)
                                      .allAssetsCategories
                                      .allAssetsCategories
                                      .map((e) => e.name.toLowerCase())
                                      .toList()
                                      .contains(value.toLowerCase());
                                  if (isCategoryExists) {
                                    return AppLocalizations.of(context)!
                                        .item_category_exists;
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  assetCategoryModel = assetCategoryModel
                                      .copyWith(name: value?.trim());
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
                          AppLocalizations.of(context)!
                              .user_profile_add_user_personal_data_save,
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          formKey.currentState!.save();

                          // add new category
                          if (assetCategory == null) {
                            context.read<AssetCategoryManagementBloc>().add(
                                  AddAssetCategoryEvent(
                                    assetCategory: assetCategoryModel,
                                  ),
                                );
                            // update category
                          } else {
                            context.read<AssetCategoryManagementBloc>().add(
                                  UpdateAssetCategoryEvent(
                                    assetCategory: assetCategoryModel,
                                  ),
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
