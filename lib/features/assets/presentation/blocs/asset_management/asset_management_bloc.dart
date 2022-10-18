import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/bloc_message.dart';
import '../../../data/models/asset_model.dart';
import '../../../domain/usecases/add_asset.dart';
import '../../../domain/usecases/delete_asset.dart';
import '../../../domain/usecases/update_asset.dart';

part 'asset_management_event.dart';
part 'asset_management_state.dart';

@injectable
class AssetManagementBloc
    extends Bloc<AssetManagementEvent, AssetManagementState> {
  final CompanyProfileBloc companyProfileBloc;
  final AddAsset addAsset;
  final DeleteAsset deleteAsset;
  final UpdateAsset updateAsset;

  late StreamSubscription _companyProfileStreamSubscription;
  String _companyId = '';

  AssetManagementBloc({
    required this.companyProfileBloc,
    required this.addAsset,
    required this.deleteAsset,
    required this.updateAsset,
  }) : super(AssetManagementEmptyState()) {
    _companyProfileStreamSubscription =
        companyProfileBloc.stream.listen((state) {
      if (state is CompanyProfileLoaded && _companyId.isEmpty) {
        _companyId = state.company.id;
      }
    });

    on<AddAssetEvent>((event, emit) async {
      emit(AssetManagementLoadingState());
      final failureOrString = await addAsset(
        AssetParams(
          asset: event.asset,
          companyId: _companyId,
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
    _companyProfileStreamSubscription.cancel();
    return super.close();
  }
}
