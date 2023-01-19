import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../assets/data/models/assets_list_model.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../domain/usecases/get_assets_stream_for_parent.dart';

part 'asset_parts_event.dart';
part 'asset_parts_state.dart';

@injectable
class AssetPartsBloc extends Bloc<AssetPartsEvent, AssetPartsState> {
  final UserProfileBloc userProfileBloc;
  final GetAssetsStreamForParent getAssetsStreamForParent;

  StreamSubscription? _streamSubscription;

  String _companyId = '';

  AssetPartsBloc({
    required this.userProfileBloc,
    required this.getAssetsStreamForParent,
  }) : super(AssetPartsEmptyState()) {
    on<GetAssetsForParentEvent>((event, emit) async {
      emit(AssetPartsLoadingState());
      _getCompanyId();
      if (_companyId.isNotEmpty) {
        final params = IdParams(
          id: event.parentAssetId,
          companyId: _companyId,
        );
        final failureOrAssets = await getAssetsStreamForParent(params);
        await failureOrAssets.fold(
          (failure) async => emit(
            AssetPartsErrorState(message: failure.message),
          ),
          (assetsStream) {
            _streamSubscription?.cancel();
            _streamSubscription = assetsStream.allAssets.listen((snapshot) {
              add(
                UpdateAssetPartsListEvent(
                  snapshot: snapshot,
                  parentAssetId: event.parentAssetId,
                ),
              );
            });
          },
        );
      } else {
        emit(const AssetPartsErrorState());
      }
    });

    on<UpdateAssetPartsListEvent>(
      (event, emit) async {
        final assetParts = AssetsListModel.fromSnapshot(
          event.snapshot as QuerySnapshot<Map<String, dynamic>>,
        );
        print('AssetPartsBloc - Loaded');
        emit(
          AssetPartsLoadedState(
            allAssetParts: assetParts,
            parentId: event.parentAssetId,
          ),
        );
      },
    );
  }

  void _getCompanyId() {
    if (_companyId.isEmpty) {
      final userState = userProfileBloc.state;
      if (userState is Approved) {
        _companyId = userState.userProfile.companyId;
      }
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
