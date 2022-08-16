import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/inventory/data/models/items_categories_list_model.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/get_items_categories_stream.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

part 'item_category_event.dart';
part 'item_category_state.dart';

@lazySingleton
class ItemCategoryBloc extends Bloc<ItemCategoryEvent, ItemCategoryState> {
  late StreamSubscription userProfileStreamSubscription;
  StreamSubscription? itemscategoriesStreamSubscription;
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
        add(GetAllItemscategoriesEvent());
      }
    });

    on<ItemCategoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
