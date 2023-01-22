import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';

import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/asset_category/assets_categories_list_model.dart';
import '../../../domain/entities/asset_category/asset_category.dart';
import '../../../domain/usecases/asset_category/get_assets_categories_stream.dart';

part 'asset_category_event.dart';
part 'asset_category_state.dart';

@singleton
class AssetCategoryBloc extends Bloc<AssetCategoryEvent, AssetCategoryState> {
  final UserProfileBloc userProfileBloc;
  final AuthenticationBloc authenticationBloc;
  final GetAssetsCategoriesStream getAssetsCategoriesStream;

  late StreamSubscription _authStreamSubscription;
  late StreamSubscription _userProfileStreamSubscription;
  StreamSubscription? _assetsCategoriesStreamSubscription;

  String _companyId = '';

  AssetCategoryBloc({
    required this.authenticationBloc,
    required this.userProfileBloc,
    required this.getAssetsCategoriesStream,
  }) : super(AssetCategoryEmptyState()) {
    _authStreamSubscription = authenticationBloc.stream.listen((state) {
      if (state is Unauthenticated) {
        add(ResetEvent());
      }
    });
    _userProfileStreamSubscription = userProfileBloc.stream.listen((state) {
      if (_companyId.isEmpty && state is Approved) {
        _companyId = state.userProfile.companyId;
        add(GetAllAssetsCategoriesEvent());
      }
    });

    on<ResetEvent>((event, emit) {
      _companyId = '';
      _assetsCategoriesStreamSubscription?.cancel();
      emit(AssetCategoryEmptyState());
    });

    on<GetAllAssetsCategoriesEvent>((event, emit) async {
      emit(AssetCategoryLoadingState());

      final failureOrAssetCategoriesStream =
          await getAssetsCategoriesStream(_companyId);
      await failureOrAssetCategoriesStream.fold(
        (failure) async => emit(
          AssetCategoryErrorState(message: failure.message),
        ),
        (categoriesStream) async {
          _assetsCategoriesStreamSubscription =
              categoriesStream.allAssetsCategories.listen((snapshot) {
            add(UpdateAssetsCategoriesListEvent(snapshot: snapshot));
          });
        },
      );
    });

    on<UpdateAssetsCategoriesListEvent>(
      (event, emit) async {
        emit(AssetCategoryLoadingState());
        final assetCategoryList = AssetsCategoriesListModel.fromSnapshot(
          event.snapshot as QuerySnapshot<Map<String, dynamic>>,
        );
        emit(
          AssetCategoryLoadedState(
            allAssetsCategories: assetCategoryList,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    _userProfileStreamSubscription.cancel();
    _assetsCategoriesStreamSubscription?.cancel();
    return super.close();
  }
}
