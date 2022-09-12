import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/data/models/item_action/item_action_model.dart';
import 'package:under_control_v2/features/inventory/data/models/item_amount_in_location_model.dart';
import 'package:under_control_v2/features/inventory/data/models/item_model.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_action/item_action.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_amount_in_location.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/add_item_action.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/delete_item_action.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/update_item_action.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';

part 'item_action_management_event.dart';
part 'item_action_management_state.dart';

enum ItemActionMessage {
  empty,
  added,
  notAdded,
  updated,
  notUpdated,
  deleted,
  notDeleted,
  moved,
  notMoved,
}

@injectable
class ItemActionManagementBloc
    extends Bloc<ItemActionManagementEvent, ItemActionManagementState> {
  late StreamSubscription companyProfileStreamSubscription;
  final CompanyProfileBloc companyProfileBloc;
  final AddItemAction addItemAction;
  final UpdateItemAction updateItemAction;
  final DeleteItemAction deleteItemAction;

  String companyId = '';

  ItemActionManagementBloc({
    required this.companyProfileBloc,
    required this.addItemAction,
    required this.updateItemAction,
    required this.deleteItemAction,
  }) : super(ItemActionManagementEmptyState()) {
    companyProfileStreamSubscription =
        companyProfileBloc.stream.listen((state) {
      if (state is CompanyProfileLoaded && companyId.isEmpty) {
        companyId = state.company.id;
      }
    });

    on<AddItemActionEvent>((event, emit) async {
      emit(ItemActionManagementLoadingState());
      ItemAmountInLocationModel itemAmountInLocation;
      int index = event.item.amountInLocations.indexWhere(
        (element) => element.locationId == event.itemAction.locationId,
      );
      // if item exist in location
      if (index >= 0) {
        itemAmountInLocation = event.item.amountInLocations[index];
        // if there is no item in location
      } else {
        itemAmountInLocation = ItemAmountInLocationModel(
          amount: 0,
          locationId: event.itemAction.locationId,
        );
      }
      // updates amount in location
      if (event.itemAction.type == ItemActionType.add) {
        itemAmountInLocation = itemAmountInLocation.copyWith(
          amount: itemAmountInLocation.amount + event.itemAction.ammount,
        );
      } else if (event.itemAction.type == ItemActionType.remove) {
        itemAmountInLocation = itemAmountInLocation.copyWith(
          amount: itemAmountInLocation.amount - event.itemAction.ammount,
        );
      }
      final amountInLocations = [...event.item.amountInLocations];
      final itemLocations = [...event.item.locations];
      if (index >= 0) {
        amountInLocations.insert(index, itemAmountInLocation);
      } else {
        amountInLocations.add(itemAmountInLocation);
        itemLocations.add(itemAmountInLocation.locationId);
      }
      ItemModel updatedItem = event.item.copyWith(
        amountInLocations: amountInLocations,
        locations: itemLocations,
      );

      final failureOrString = await addItemAction(
        ItemActionParams(
          updatedItem: updatedItem,
          itemAction: event.itemAction,
          companyId: companyId,
        ),
      );
      await failureOrString.fold(
        (failure) async => emit(
          ItemActionManagementErrorState(
            message: ItemActionMessage.notAdded,
          ),
        ),
        (_) async {
          emit(
            ItemActionManagementSuccessState(
              message: ItemActionMessage.added,
            ),
          );
        },
      );
    });

    on<UpdateItemActionEvent>((event, emit) async {
      emit(ItemActionManagementLoadingState());
      ItemAmountInLocationModel itemAmountInLocation;
      int index = event.item.amountInLocations.indexWhere(
        (element) => element.locationId == event.itemAction.locationId,
      );
      // if item exist in location
      if (index >= 0) {
        itemAmountInLocation = event.item.amountInLocations[index];
        // if there is no item in location
      } else {
        emit(
          ItemActionManagementErrorState(
            message: ItemActionMessage.notUpdated,
          ),
        );
        return;
      }
      // remove old action
      if (event.oldItemAction!.type == ItemActionType.add) {
        itemAmountInLocation = itemAmountInLocation.copyWith(
          amount: itemAmountInLocation.amount - event.oldItemAction!.ammount,
        );
      } else if (event.oldItemAction!.type == ItemActionType.remove) {
        itemAmountInLocation = itemAmountInLocation.copyWith(
          amount: itemAmountInLocation.amount + event.oldItemAction!.ammount,
        );
      }
      // updates amount in location
      if (event.itemAction.type == ItemActionType.add) {
        itemAmountInLocation = itemAmountInLocation.copyWith(
          amount: itemAmountInLocation.amount + event.itemAction.ammount,
        );
      } else if (event.itemAction.type == ItemActionType.remove) {
        itemAmountInLocation = itemAmountInLocation.copyWith(
          amount: itemAmountInLocation.amount - event.itemAction.ammount,
        );
      }
      final amountInLocations = [...event.item.amountInLocations];
      final itemLocations = [...event.item.locations];

      amountInLocations.insert(index, itemAmountInLocation);

      ItemModel updatedItem = event.item.copyWith(
        amountInLocations: amountInLocations,
        locations: itemLocations,
      );

      final failureOrVoidResult = await updateItemAction(
        ItemActionParams(
          updatedItem: updatedItem,
          itemAction: event.itemAction,
          companyId: companyId,
        ),
      );
      await failureOrVoidResult.fold(
        (failure) async => emit(
          ItemActionManagementErrorState(
            message: ItemActionMessage.notUpdated,
          ),
        ),
        (_) async {
          emit(
            ItemActionManagementSuccessState(
              message: ItemActionMessage.updated,
            ),
          );
        },
      );
    });

    on<DeleteItemActionEvent>((event, emit) async {
      emit(ItemActionManagementLoadingState());
      ItemAmountInLocationModel itemAmountInLocation;
      int index = event.item.amountInLocations.indexWhere(
        (element) => element.locationId == event.itemAction.locationId,
      );
      // if item exist in location
      if (index >= 0) {
        itemAmountInLocation = event.item.amountInLocations[index];
        // if there is no item in location
      } else {
        emit(
          ItemActionManagementErrorState(
            message: ItemActionMessage.notDeleted,
          ),
        );
        return;
      }
      // updates amount in location
      if (event.itemAction.type == ItemActionType.add) {
        itemAmountInLocation = itemAmountInLocation.copyWith(
          amount: itemAmountInLocation.amount - event.itemAction.ammount,
        );
      } else if (event.itemAction.type == ItemActionType.remove) {
        itemAmountInLocation = itemAmountInLocation.copyWith(
          amount: itemAmountInLocation.amount + event.itemAction.ammount,
        );
      }
      final amountInLocations = [...event.item.amountInLocations];
      final itemLocations = [...event.item.locations];

      amountInLocations.insert(index, itemAmountInLocation);

      ItemModel updatedItem = event.item.copyWith(
        amountInLocations: amountInLocations,
        locations: itemLocations,
      );

      final failureOrVoidResult = await deleteItemAction(
        ItemActionParams(
          updatedItem: updatedItem,
          itemAction: event.itemAction,
          companyId: companyId,
        ),
      );
      await failureOrVoidResult.fold(
        (failure) async => emit(
          ItemActionManagementErrorState(
            message: ItemActionMessage.notDeleted,
          ),
        ),
        (_) async {
          emit(
            ItemActionManagementSuccessState(
              message: ItemActionMessage.deleted,
            ),
          );
        },
      );
    });
  }

  @override
  Future<void> close() {
    companyProfileStreamSubscription.cancel();
    return super.close();
  }
}
