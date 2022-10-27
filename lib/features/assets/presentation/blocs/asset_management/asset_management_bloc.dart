import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
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

  late StreamSubscription _userProfileStreamSubscription;
  String _companyId = '';
  String _userId = '';

  AssetManagementBloc({
    required this.userProfileBloc,
    required this.addAsset,
    required this.deleteAsset,
    required this.updateAsset,
  }) : super(AssetManagementEmptyState()) {
    _userProfileStreamSubscription = userProfileBloc.stream.listen((state) {
      if (state is Approved && _companyId.isEmpty) {
        _companyId = state.userProfile.companyId;
        _userId = state.userProfile.id;
      }
    });

    on<AddAssetEvent>((event, emit) async {
      emit(AssetManagementLoadingState());
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

  @override
  Future<void> close() {
    _userProfileStreamSubscription.cancel();
    return super.close();
  }
}
