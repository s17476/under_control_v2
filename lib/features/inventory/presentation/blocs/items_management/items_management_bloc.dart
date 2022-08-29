import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/add_item.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/update_item.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../domain/entities/item.dart';

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
  late StreamSubscription companyProfileStreamSubscription;
  final CompanyProfileBloc companyProfileBloc;
  final AddItem addItem;
  final DeleteItem deleteItem;
  final UpdateItem updateItem;

  String companyId = '';

  ItemsManagementBloc({
    required this.companyProfileBloc,
    required this.addItem,
    required this.deleteItem,
    required this.updateItem,
  }) : super(ItemsManagementEmptyState()) {
    companyProfileStreamSubscription =
        companyProfileBloc.stream.listen((state) {
      if (state is CompanyProfileLoaded && companyId.isEmpty) {
        companyId = state.company.id;
      }
    });

    on<AddItemEvent>(
      (event, emit) async {
        emit(ItemsManagementLoadingState());
        final failureOrString = await addItem(
          ItemParams(
            item: event.item,
            companyId: companyId,
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
        final failureOrVoidResult = await deleteItem(
          ItemParams(
            item: event.item,
            companyId: companyId,
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
        final failureOrVoidResult = await updateItem(
          ItemParams(
            item: event.item,
            companyId: companyId,
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
}
