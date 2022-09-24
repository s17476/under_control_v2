import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/data/models/item_action/item_actions_list_model.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_item_actions_stream.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart';

import '../../../domain/entities/item.dart';

part 'item_action_event.dart';
part 'item_action_state.dart';

@injectable
class ItemActionBloc extends Bloc<ItemActionEvent, ItemActionState> {
  StreamSubscription? itemsActionsStreamSubscription;
  final GetItemsActionsStream getItemsActionsStream;
  final GetLastFiveItemsActionsStream getLastFiveItemsActionsStream;

  ItemActionBloc({
    required this.getItemsActionsStream,
    required this.getLastFiveItemsActionsStream,
  }) : super(ItemActionEmptyState()) {
    on<GetItemActionsEvent>((event, emit) async {
      emit(ItemActionLoadingState());

      final _itemParams =
          ItemParams(item: event.item, companyId: event.companyId);

      final failureOrItemActionsStream =
          await getItemsActionsStream(_itemParams);
      await failureOrItemActionsStream.fold(
        (failure) async => emit(ItemActionErrorState(message: failure.message)),
        (actionsStream) async {
          itemsActionsStreamSubscription =
              actionsStream.allItemActions.listen((snapshot) {
            add(
              UpdateItemActionsListEvent(snapshot: snapshot, limit: 0),
            );
          });
        },
      );
    });

    on<GetLastFiveItemActionsEvent>((event, emit) async {
      emit(ItemActionLoadingState());

      final _itemParams =
          ItemParams(item: event.item, companyId: event.companyId);

      final failureOrItemActionsStream =
          await getLastFiveItemsActionsStream(_itemParams);
      await failureOrItemActionsStream.fold(
        (failure) async => emit(ItemActionErrorState(message: failure.message)),
        (actionsStream) async {
          itemsActionsStreamSubscription =
              actionsStream.allItemActions.listen((snapshot) {
            add(
              UpdateItemActionsListEvent(snapshot: snapshot, limit: 5),
            );
          });
        },
      );
    });

    on<UpdateItemActionsListEvent>(
      (event, emit) async {
        emit(ItemActionLoadingState());
        final itemActionsList = ItemActionsListModel.fromSnapshot(
            event.snapshot as QuerySnapshot<Map<String, dynamic>>);
        emit(
          ItemActionLoadedState(
            allActions: itemActionsList,
            isAllItems: event.limit == 0,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    itemsActionsStreamSubscription?.cancel();
    return super.close();
  }
}
