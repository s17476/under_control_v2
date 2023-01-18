import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/item_model.dart';
import '../../../domain/entities/item.dart';
import '../../../domain/usecases/add_item.dart';
import '../../../domain/usecases/add_item_photo.dart';
import '../../../domain/usecases/delete_item.dart';
import '../../../domain/usecases/delete_item_photo.dart';
import '../../../domain/usecases/update_item.dart';
import '../../../domain/usecases/update_item_photo.dart';

part 'items_management_event.dart';
part 'items_management_state.dart';

enum ItemsMessage {
  empty,
  itemAdded,
  itemNotAdded,
  itemUpdated,
  itemNotUpdated,
  itemDeleted,
  itemNotDeleted,
  itemInUse,
}

@injectable
class ItemsManagementBloc
    extends Bloc<ItemsManagementEvent, ItemsManagementState> {
  final UserProfileBloc userProfileBloc;
  final AddItem addItem;
  final DeleteItem deleteItem;
  final UpdateItem updateItem;
  final AddItemPhoto addItemPhoto;
  final DeleteItemPhoto deleteItemPhoto;
  final UpdateItemPhoto updateItemPhoto;

  String _companyId = '';

  ItemsManagementBloc({
    required this.addItemPhoto,
    required this.deleteItemPhoto,
    required this.updateItemPhoto,
    required this.userProfileBloc,
    required this.addItem,
    required this.deleteItem,
    required this.updateItem,
  }) : super(ItemsManagementEmptyState()) {
    on<AddItemEvent>(
      (event, emit) async {
        emit(ItemsManagementLoadingState());
        _getCompanyId();
        ItemModel item = event.item as ItemModel;
        final failureOrImageUrl = await addItemPhoto(
          ItemParams(
            item: event.item,
            companyId: _companyId,
            photo: event.itemPhoto,
          ),
        );
        failureOrImageUrl.fold(
          (failure) => null,
          (imageUrl) {
            item = item.copyWith(itemPhoto: imageUrl);
          },
        );
        final failureOrString = await addItem(
          ItemParams(
            item: item,
            companyId: _companyId,
            documents: event.documents,
          ),
        );
        await failureOrString.fold(
          (failure) async => emit(
            ItemsManagementErrorState(
              message: ItemsMessage.itemNotAdded,
            ),
          ),
          (_) async => emit(
            ItemsManagementSuccessState(
              message: ItemsMessage.itemAdded,
            ),
          ),
        );
      },
    );

    on<DeleteItemEvent>(
      (event, emit) async {
        emit(ItemsManagementLoadingState());
        _getCompanyId();
        final failureOrVoidResult = await deleteItem(
          ItemParams(
            item: event.item,
            companyId: _companyId,
          ),
        );
        await failureOrVoidResult.fold(
          (failure) async => emit(
            ItemsManagementErrorState(
              message: ItemsMessage.itemNotDeleted,
            ),
          ),
          (_) async => emit(
            ItemsManagementSuccessState(
              message: ItemsMessage.itemDeleted,
            ),
          ),
        );
      },
    );

    on<UpdateItemEvent>(
      (event, emit) async {
        emit(ItemsManagementLoadingState());
        _getCompanyId();
        ItemModel item = event.item as ItemModel;
        final failureOrImageUrl = await addItemPhoto(
          ItemParams(
            item: event.item,
            companyId: _companyId,
            photo: event.itemPhoto,
          ),
        );
        failureOrImageUrl.fold(
          (failure) => null,
          (imageUrl) {
            item = item.copyWith(itemPhoto: imageUrl);
          },
        );
        final failureOrVoidResult = await updateItem(
          ItemParams(
            item: item,
            companyId: _companyId,
            documents: event.documents,
          ),
        );
        await failureOrVoidResult.fold(
          (failure) async => emit(
            ItemsManagementErrorState(
              message: ItemsMessage.itemNotUpdated,
            ),
          ),
          (_) async => emit(
            ItemsManagementSuccessState(
              message: ItemsMessage.itemUpdated,
            ),
          ),
        );
      },
    );
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
