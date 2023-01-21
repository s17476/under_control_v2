import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/bloc_message.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/asset_action/asset_action_model.dart';
import '../../../data/models/asset_model.dart';
import '../../../domain/usecases/asset_action/add_asset_action.dart';
import '../../../domain/usecases/asset_action/delete_asset_action.dart';
import '../../../domain/usecases/asset_action/update_asset_action.dart';

part 'asset_action_management_event.dart';
part 'asset_action_management_state.dart';

@injectable
class AssetActionManagementBloc
    extends Bloc<AssetActionManagementEvent, AssetActionManagementState> {
  final UserProfileBloc userProfileBloc;
  final AddAssetAction addAssetAction;
  final UpdateAssetAction updateAssetAction;
  final DeleteAssetAction deleteAssetAction;

  String _companyId = '';

  AssetActionManagementBloc({
    required this.userProfileBloc,
    required this.addAssetAction,
    required this.updateAssetAction,
    required this.deleteAssetAction,
  }) : super(AssetActionManagementEmptyState()) {
    on<AddAssetActionEvent>((event, emit) async {
      emit(AssetActionManagementLoadingState());
      _getCompanyId();
      final updatedAsset = event.asset.copyWith(
        isInUse: event.assetAction.isAssetInUse,
        currentStatus: event.assetAction.assetStatus,
      );
      final failureOrString = await addAssetAction(
        AssetActionParams(
          updatedAsset: updatedAsset,
          assetAction: event.assetAction,
          companyId: _companyId,
        ),
      );
      await failureOrString.fold(
        (failure) async => emit(
          AssetActionManagementErrorState(
            message: BlocMessage.notAdded,
          ),
        ),
        (_) async => emit(
          AssetActionManagementSuccessState(
            message: BlocMessage.added,
          ),
        ),
      );
    });

    on<DeleteAssetActionEvent>((event, emit) async {
      emit(AssetActionManagementLoadingState());
      _getCompanyId();
      final updatedAsset = event.asset.copyWith(
        isInUse: event.assetAction.isAssetInUse,
        currentStatus: event.assetAction.assetStatus,
      );
      final failureOrVoidResult = await deleteAssetAction(
        AssetActionParams(
          updatedAsset: updatedAsset,
          assetAction: event.assetAction,
          companyId: _companyId,
        ),
      );
      await failureOrVoidResult.fold(
        (failure) async => emit(
          AssetActionManagementErrorState(
            message: BlocMessage.notAdded,
          ),
        ),
        (_) async => emit(
          AssetActionManagementSuccessState(
            message: BlocMessage.added,
          ),
        ),
      );
    });

    on<UpdateAssetActionEvent>((event, emit) async {
      emit(AssetActionManagementLoadingState());
      _getCompanyId();
      final updatedAsset = event.asset.copyWith(
        isInUse: event.assetAction.isAssetInUse,
        currentStatus: event.assetAction.assetStatus,
      );
      final failureOrVoidResult = await updateAssetAction(
        AssetActionParams(
          updatedAsset: updatedAsset,
          assetAction: event.assetAction,
          companyId: _companyId,
        ),
      );
      await failureOrVoidResult.fold(
        (failure) async => emit(
          AssetActionManagementErrorState(
            message: BlocMessage.notAdded,
          ),
        ),
        (_) async => emit(
          AssetActionManagementSuccessState(
            message: BlocMessage.added,
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
