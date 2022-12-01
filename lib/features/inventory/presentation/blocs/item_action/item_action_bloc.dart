import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../data/models/item_action/item_actions_list_model.dart';
import '../../../domain/entities/item.dart';
import '../../../domain/usecases/item_action/get_item_actions_stream.dart';
import '../../../domain/usecases/item_action/get_last_five_item_actions_stream.dart';

part 'item_action_event.dart';
part 'item_action_state.dart';

@injectable
class ItemActionBloc extends Bloc<ItemActionEvent, ItemActionState> {
  final GetItemsActionsStream getItemsActionsStream;
  final GetLastFiveItemsActionsStream getLastFiveItemsActionsStream;

  StreamSubscription? _itemsActionsStreamSubscription;

  ItemActionBloc({
    required this.getItemsActionsStream,
    required this.getLastFiveItemsActionsStream,
  }) : super(ItemActionEmptyState()) {
    on<GetItemActionsEvent>((event, emit) async {
      emit(ItemActionLoadingState());

      final itemParams =
          ItemParams(item: event.item, companyId: event.companyId);

      final failureOrItemActionsStream =
          await getItemsActionsStream(itemParams);
      await failureOrItemActionsStream.fold(
        (failure) async => emit(ItemActionErrorState(message: failure.message)),
        (actionsStream) async {
          _itemsActionsStreamSubscription =
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

      final itemParams =
          ItemParams(item: event.item, companyId: event.companyId);

      final failureOrItemActionsStream =
          await getLastFiveItemsActionsStream(itemParams);
      await failureOrItemActionsStream.fold(
        (failure) async => emit(ItemActionErrorState(message: failure.message)),
        (actionsStream) async {
          _itemsActionsStreamSubscription =
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
    _itemsActionsStreamSubscription?.cancel();
    return super.close();
  }
}
