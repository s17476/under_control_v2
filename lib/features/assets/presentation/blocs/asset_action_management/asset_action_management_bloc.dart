import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/utils/bloc_message.dart';
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
  final CompanyProfileBloc companyProfileBloc;
  final AddAssetAction addAssetAction;
  final UpdateAssetAction updateAssetAction;
  final DeleteAssetAction deleteAssetAction;

  late StreamSubscription _companyprofileStreamSubscription;
  String _companyId = '';

  AssetActionManagementBloc({
    required this.companyProfileBloc,
    required this.addAssetAction,
    required this.updateAssetAction,
    required this.deleteAssetAction,
  }) : super(AssetActionManagementEmptyState()) {
    _companyprofileStreamSubscription =
        companyProfileBloc.stream.listen((state) {
      if (state is CompanyProfileLoaded && _companyId.isEmpty) {
        _companyId = state.company.id;
      }
    });

    on<AddAssetActionEvent>((event, emit) async {
      emit(AssetActionManagementLoadingState());
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

  @override
  Future<void> close() {
    _companyprofileStreamSubscription.cancel();
    return super.close();
  }
}
