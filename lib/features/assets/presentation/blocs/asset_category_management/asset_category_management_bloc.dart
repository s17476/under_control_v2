import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/bloc_message.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../domain/entities/asset_category/asset_category.dart';
import '../../../domain/usecases/asset_category/add_asset_category.dart';
import '../../../domain/usecases/asset_category/delete_asset_category.dart';
import '../../../domain/usecases/asset_category/update_asset_category.dart';

part 'asset_category_management_event.dart';
part 'asset_category_management_state.dart';

@injectable
class AssetCategoryManagementBloc
    extends Bloc<AssetCategoryManagementEvent, AssetCategoryManagementState> {
  final UserProfileBloc userProfileBloc;
  final AddAssetCategory addAssetCategory;
  final UpdateAssetCategory updateAssetCategory;
  final DeleteAssetCategory deleteAssetCategory;

  String _companyId = '';

  AssetCategoryManagementBloc({
    required this.userProfileBloc,
    required this.addAssetCategory,
    required this.updateAssetCategory,
    required this.deleteAssetCategory,
  }) : super(AssetCategoryManagementEmptyState()) {
    on<AddAssetCategoryEvent>((event, emit) async {
      emit(AssetCategoryManagementLoadingState());
      _getCompanyId();
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
      _getCompanyId();
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
      _getCompanyId();
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

  void _getCompanyId() {
    final userState = userProfileBloc.state;
    if (userState is Approved) {
      _companyId = userState.userProfile.companyId;
    }
  }
}
