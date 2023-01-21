import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/bloc_message.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/asset_model.dart';
import '../../../domain/usecases/add_asset.dart';
import '../../../domain/usecases/delete_asset.dart';
import '../../../domain/usecases/update_asset.dart';

part 'asset_management_event.dart';
part 'asset_management_state.dart';

@injectable
class AssetManagementBloc
    extends Bloc<AssetManagementEvent, AssetManagementState> {
  final UserProfileBloc userProfileBloc;
  final AddAsset addAsset;
  final DeleteAsset deleteAsset;
  final UpdateAsset updateAsset;

  String _companyId = '';
  String _userId = '';

  AssetManagementBloc({
    required this.userProfileBloc,
    required this.addAsset,
    required this.deleteAsset,
    required this.updateAsset,
  }) : super(AssetManagementEmptyState()) {
    on<AddAssetEvent>((event, emit) async {
      emit(AssetManagementLoadingState());
      _getCompanyAndUserId();
      final failureOrString = await addAsset(
        AssetParams(
          asset: event.asset,
          companyId: _companyId,
          documents: event.documents,
          images: event.images,
          userId: _userId,
        ),
      );
      await failureOrString.fold(
        (failure) async => emit(
          const AssetManagementErrorState(
            message: BlocMessage.notAdded,
          ),
        ),
        (_) async => emit(
          const AssetManagementSuccessState(
            message: BlocMessage.added,
          ),
        ),
      );
    });

    on<DeleteAssetEvent>((event, emit) async {
      emit(AssetManagementLoadingState());
      _getCompanyAndUserId();
      final failureOrVoidResult = await deleteAsset(
        AssetParams(
          asset: event.asset,
          companyId: _companyId,
        ),
      );
      await failureOrVoidResult.fold(
        (failure) async => emit(
          const AssetManagementErrorState(
            message: BlocMessage.notDeleted,
          ),
        ),
        (_) async => emit(
          const AssetManagementSuccessState(
            message: BlocMessage.deleted,
          ),
        ),
      );
    });

    on<UpdateAssetEvent>((event, emit) async {
      emit(AssetManagementLoadingState());
      _getCompanyAndUserId();
      final failureOrVoidResult = await updateAsset(
        AssetParams(
          asset: event.asset,
          companyId: _companyId,
          documents: event.documents,
          images: event.images,
          userId: _userId,
        ),
      );
      await failureOrVoidResult.fold(
        (failure) async => emit(
          const AssetManagementErrorState(
            message: BlocMessage.notUpdated,
          ),
        ),
        (_) async => emit(
          const AssetManagementSuccessState(
            message: BlocMessage.updated,
          ),
        ),
      );
    });
  }

  void _getCompanyAndUserId() {
    final userState = userProfileBloc.state;
    if (userState is Approved) {
      _companyId = userState.userProfile.companyId;
      _userId = userState.userProfile.id;
    }
  }
}
