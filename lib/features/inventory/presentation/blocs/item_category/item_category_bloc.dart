import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_category/item_category.dart';

import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/item_category/items_categories_list_model.dart';
import '../../../domain/usecases/item_category/get_items_categories_stream.dart';

part 'item_category_event.dart';
part 'item_category_state.dart';

@lazySingleton
class ItemCategoryBloc extends Bloc<ItemCategoryEvent, ItemCategoryState> {
  late StreamSubscription userProfileStreamSubscription;
  StreamSubscription? itemsCategoriesStreamSubscription;
  final UserProfileBloc userProfileBloc;
  final GetItemsCategoriesStream getItemsCategoriesStream;

  String companyId = '';

  ItemCategoryBloc({
    required this.userProfileBloc,
    required this.getItemsCategoriesStream,
  }) : super(ItemCategoryEmptyState()) {
    userProfileStreamSubscription = userProfileBloc.stream.listen((state) {
      if (state is Approved) {
        companyId = state.userProfile.companyId;
        add(GetAllItemsCategoriesEvent());
      }
    });

    on<GetAllItemsCategoriesEvent>((event, emit) async {
      emit(ItemCategoryLoadingState());

      final failureIrItemCategoriesStream =
          await getItemsCategoriesStream(companyId);
      await failureIrItemCategoriesStream.fold(
        (failure) async => emit(
          ItemCategoryErrorState(message: failure.message),
        ),
        (categoriesStream) async {
          itemsCategoriesStreamSubscription =
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
    userProfileStreamSubscription.cancel();
    itemsCategoriesStreamSubscription?.cancel();
    return super.close();
  }
}
