import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';

import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/item_category/items_categories_list_model.dart';
import '../../../domain/entities/item_category/item_category.dart';
import '../../../domain/usecases/item_category/get_items_categories_stream.dart';

part 'item_category_event.dart';
part 'item_category_state.dart';

@singleton
class ItemCategoryBloc extends Bloc<ItemCategoryEvent, ItemCategoryState> {
  final AuthenticationBloc authenticationBloc;
  final UserProfileBloc userProfileBloc;
  final GetItemsCategoriesStream getItemsCategoriesStream;

  late StreamSubscription _authStreamSubscription;
  late StreamSubscription _userProfileStreamSubscription;
  StreamSubscription? _itemsCategoriesStreamSubscription;

  String _companyId = '';

  ItemCategoryBloc({
    required this.authenticationBloc,
    required this.userProfileBloc,
    required this.getItemsCategoriesStream,
  }) : super(ItemCategoryEmptyState()) {
    _authStreamSubscription = authenticationBloc.stream.listen((state) {
      if (state is Unauthenticated) {
        add(ResetEvent());
      }
    });
    _userProfileStreamSubscription = userProfileBloc.stream.listen((state) {
      if (_companyId.isEmpty && state is Approved) {
        _companyId = state.userProfile.companyId;
        add(GetAllItemsCategoriesEvent());
      }
    });

    on<ResetEvent>(
      (event, emit) {
        _companyId = '';
        _itemsCategoriesStreamSubscription?.cancel();
        emit(ItemCategoryEmptyState());
      },
    );

    on<GetAllItemsCategoriesEvent>((event, emit) async {
      emit(ItemCategoryLoadingState());

      final failureIrItemCategoriesStream =
          await getItemsCategoriesStream(_companyId);
      await failureIrItemCategoriesStream.fold(
        (failure) async => emit(
          ItemCategoryErrorState(message: failure.message),
        ),
        (categoriesStream) async {
          _itemsCategoriesStreamSubscription =
              categoriesStream.allItemsCategories.listen((snapshot) {
            add(UpdateItemsCategoriesListEvent(snapshot: snapshot));
          });
        },
      );
    });

    on<UpdateItemsCategoriesListEvent>(
      (event, emit) async {
        emit(ItemCategoryLoadingState());
        final itemCategoryList = ItemsCategoriesListModel.fromSnapshot(
          event.snapshot as QuerySnapshot<Map<String, dynamic>>,
        );
        emit(ItemCategoryLoadedState(allItemsCategories: itemCategoryList));
      },
    );
  }

  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    _userProfileStreamSubscription.cancel();
    _itemsCategoriesStreamSubscription?.cancel();
    return super.close();
  }
}
