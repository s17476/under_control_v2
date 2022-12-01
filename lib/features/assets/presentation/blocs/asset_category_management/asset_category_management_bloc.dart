import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/bloc_message.dart';
import '../../../domain/entities/asset_category/asset_category.dart';
import '../../../domain/usecases/asset_category/add_asset_category.dart';
import '../../../domain/usecases/asset_category/delete_asset_category.dart';
import '../../../domain/usecases/asset_category/update_asset_category.dart';

part 'asset_category_management_event.dart';
part 'asset_category_management_state.dart';

@injectable
class AssetCategoryManagementBloc
    extends Bloc<AssetCategoryManagementEvent, AssetCategoryManagementState> {
  final CompanyProfileBloc companyProfileBloc;
  final AddAssetCategory addAssetCategory;
  final UpdateAssetCategory updateAssetCategory;
  final DeleteAssetCategory deleteAssetCategory;

  late StreamSubscription _companyProfileStreamSubscription;
  String _companyId = '';

  AssetCategoryManagementBloc({
    required this.companyProfileBloc,
    required this.addAssetCategory,
    required this.updateAssetCategory,
    required this.deleteAssetCategory,
  }) : super(AssetCategoryManagementEmptyState()) {
    _companyProfileStreamSubscription =
        companyProfileBloc.stream.listen((state) {
      if (state is CompanyProfileLoaded && _companyId.isEmpty) {
        _companyId = state.company.id;
      }
    });

    on<AddAssetCategoryEvent>((event, emit) async {
      emit(AssetCategoryManagementLoadingState());
      final failureOrString = await addAssetCategory(
        AssetCategoryParams(
          assetCategory: event.assetCategory,
          companyId: _companyId,
        ),
      );
      await failureOrString.fold(
        (failure) async => emit(
          AssetCategoryManagementErrorState(
            message: BlocMessage.notAdded,
          ),
        ),
        (_) async => emit(
          AssetCategoryManagementSuccessState(
            message: BlocMessage.added,
          ),
        ),
      );
    });

    on<UpdateAssetCategoryEvent>((event, emit) async {
      emit(AssetCategoryManagementLoadingState());
      final failureOrVoidResult = await updateAssetCategory(
        AssetCategoryParams(
          assetCategory: event.assetCategory,
          companyId: _companyId,
        ),
      );
      await failureOrVoidResult.fold(
        (failure) async => emit(
          AssetCategoryManagementErrorState(
            message: BlocMessage.notUpdated,
          ),
        ),
        (_) async => emit(
          AssetCategoryManagementSuccessState(
            message: BlocMessage.updated,
          ),
        ),
      );
    });

    on<DeleteAssetCategoryEvent>((event, emit) async {
      emit(AssetCategoryManagementLoadingState());
      final failureOrVoidResult = await deleteAssetCategory(
        AssetCategoryParams(
          assetCategory: event.assetCategory,
          companyId: _companyId,
        ),
      );
      await failureOrVoidResult.fold(
        (failure) async {
          if (failure is CategoryNotEmptyFailure) {
            emit(
              AssetCategoryManagementErrorState(
                message: BlocMessage.inUse,
              ),
            );
          } else {
            emit(
              AssetCategoryManagementErrorState(
                message: BlocMessage.notDeleted,
              ),
            );
          }
        },
        (_) async => emit(
          AssetCategoryManagementSuccessState(
            message: BlocMessage.deleted,
          ),
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _companyProfileStreamSubscription.cancel();
    return super.close();
  }
}
