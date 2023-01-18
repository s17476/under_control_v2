import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/item_action/item_action_model.dart';
import '../../../data/models/item_amount_in_location_model.dart';
import '../../../data/models/item_model.dart';
import '../../../domain/entities/item_action/item_action.dart';
import '../../../domain/usecases/item_action/add_item_action.dart';
import '../../../domain/usecases/item_action/delete_item_action.dart';
import '../../../domain/usecases/item_action/move_item_action.dart';
import '../../../domain/usecases/item_action/update_item_action.dart';

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
  final UserProfileBloc userProfileBloc;
  final AddItemAction addItemAction;
  final UpdateItemAction updateItemAction;
  final DeleteItemAction deleteItemAction;
  final MoveItemAction moveItemAction;

  String _companyId = '';

  ItemActionManagementBloc({
    required this.userProfileBloc,
    required this.addItemAction,
    required this.updateItemAction,
    required this.deleteItemAction,
    required this.moveItemAction,
  }) : super(ItemActionManagementEmptyState()) {
    on<AddItemActionEvent>((event, emit) async {
      emit(ItemActionManagementLoadingState());
      _getCompanyId();
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
        amountInLocations.removeAt(index);
        if (itemAmountInLocation.amount > 0) {
          amountInLocations.add(itemAmountInLocation);
        } else {
          itemLocations.remove(itemAmountInLocation.locationId);
        }
      } else {
        amountInLocations.add(itemAmountInLocation);
        if (!itemLocations.contains(itemAmountInLocation.locationId)) {
          itemLocations.add(itemAmountInLocation.locationId);
        }
      }
      ItemModel updatedItem = event.item.copyWith(
        amountInLocations: amountInLocations,
        locations: itemLocations,
      );

      final failureOrString = await addItemAction(
        ItemActionParams(
          updatedItem: updatedItem,
          itemAction: event.itemAction,
          companyId: _companyId,
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
      _getCompanyId();
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

      amountInLocations.removeAt(index);
      amountInLocations.insert(index, itemAmountInLocation);

      ItemModel updatedItem = event.item.copyWith(
        amountInLocations: amountInLocations,
        locations: itemLocations,
      );

      final failureOrVoidResult = await updateItemAction(
        ItemActionParams(
          updatedItem: updatedItem,
          itemAction: event.itemAction,
          companyId: _companyId,
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
      _getCompanyId();
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

      amountInLocations.removeAt(index);
      if (itemAmountInLocation.amount > 0) {
        amountInLocations.insert(index, itemAmountInLocation);
      }

      ItemModel updatedItem = event.item.copyWith(
        amountInLocations: amountInLocations,
        locations: itemLocations,
      );

      final failureOrVoidResult = await deleteItemAction(
        ItemActionParams(
          updatedItem: updatedItem,
          itemAction: event.itemAction,
          companyId: _companyId,
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

    on<MoveItemActionEvent>((event, emit) async {
      emit(ItemActionManagementLoadingState());
      _getCompanyId();
      ItemAmountInLocationModel itemAmountInOldLocation;
      ItemAmountInLocationModel itemAmountInNewLocation;

      int indexOfOldLocation = event.item.amountInLocations.indexWhere(
        (element) => element.locationId == event.oldItemAction!.locationId,
      );
      int indexOfNewLocation = event.item.amountInLocations.indexWhere(
        (element) => element.locationId == event.itemAction.locationId,
      );
      // item exist in old location
      if (indexOfOldLocation >= 0) {
        itemAmountInOldLocation =
            event.item.amountInLocations[indexOfOldLocation];
        // item in new location exists
        if (indexOfNewLocation >= 0) {
          itemAmountInNewLocation =
              event.item.amountInLocations[indexOfNewLocation];
          // there is no item to new location
        } else {
          itemAmountInNewLocation = ItemAmountInLocationModel(
            amount: 0,
            locationId: event.itemAction.locationId,
          );
        }
        // there is no item in old location
      } else {
        emit(
          ItemActionManagementErrorState(
            message: ItemActionMessage.notUpdated,
          ),
        );
        return;
      }

      // updates items amounts in locations
      itemAmountInOldLocation = itemAmountInOldLocation.copyWith(
        amount: itemAmountInOldLocation.amount - event.itemAction.ammount,
      );

      itemAmountInNewLocation = itemAmountInNewLocation.copyWith(
        amount: itemAmountInNewLocation.amount + event.itemAction.ammount,
      );

      final updatedAmountInLocations = [...event.item.amountInLocations];
      final itemLocations = [...event.item.locations];

      //
      //
      //

      // update old location
      updatedAmountInLocations.removeAt(indexOfOldLocation);
      if (itemAmountInOldLocation.amount > 0) {
        updatedAmountInLocations.insert(
            indexOfOldLocation, itemAmountInOldLocation);
      } else {
        itemLocations.remove(itemAmountInOldLocation.locationId);
        indexOfNewLocation = updatedAmountInLocations.indexWhere(
          (element) => element.locationId == event.itemAction.locationId,
        );
      }
      // item exists in new location
      if (indexOfNewLocation >= 0) {
        updatedAmountInLocations.removeAt(indexOfNewLocation);
      }
      updatedAmountInLocations.add(itemAmountInNewLocation);
      if (!itemLocations.contains(itemAmountInNewLocation.locationId)) {
        itemLocations.add(itemAmountInNewLocation.locationId);
      }

      ItemModel updatedItem = event.item.copyWith(
        amountInLocations: updatedAmountInLocations,
        locations: itemLocations,
      );

      final failureOrVoidResult = await moveItemAction(
        MoveItemActionParams(
          updatedItem: updatedItem,
          moveFromItemAction: event.oldItemAction!,
          moveToItemAction: event.itemAction,
          companyId: _companyId,
        ),
      );
      await failureOrVoidResult.fold(
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
  }

  void _getCompanyId() {
    if (_companyId.isEmpty) {
      final userState = userProfileBloc.state;
      if (userState is Approved) {
        _companyId = userState.userProfile.companyId;
      }
    }
  }
}
