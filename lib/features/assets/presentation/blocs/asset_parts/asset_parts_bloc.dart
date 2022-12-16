import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../assets/data/models/assets_list_model.dart';
import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../data/models/asset_model.dart';
import '../../../domain/usecases/get_assets_stream_for_parent.dart';

part 'asset_parts_event.dart';
part 'asset_parts_state.dart';

@injectable
class AssetPartsBloc extends Bloc<AssetPartsEvent, AssetPartsState> {
  final CompanyProfileBloc companyProfileBloc;
  final GetAssetsStreamForParent getAssetsStreamForParent;

  StreamSubscription? _streamSubscription;

  AssetPartsBloc({
    required this.companyProfileBloc,
    required this.getAssetsStreamForParent,
  }) : super(AssetPartsEmptyState()) {
    on<GetAssetsForParentEvent>((event, emit) async {
      emit(AssetPartsLoadingState());
      final companyState = companyProfileBloc.state;
      if (companyState is CompanyProfileLoaded) {
        final params = AssetParams(
          asset: event.parentAsset,
          companyId: companyState.company.id,
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
                  parentAssetId: event.parentAsset.id,
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
        emit(
          AssetPartsLoadedState(
            allAssetParts: assetParts,
            parentId: event.parentAssetId,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
