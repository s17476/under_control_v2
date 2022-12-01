import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../domain/entities/item_category/item_category.dart';
import '../../../domain/usecases/item_category/add_item_category.dart';
import '../../../domain/usecases/item_category/delete_item_category.dart';
import '../../../domain/usecases/item_category/update_item_category.dart';

part 'item_category_management_event.dart';
part 'item_category_management_state.dart';

enum ItemCategoryMessage {
  empty,
  itemCategoryAdded,
  itemCategoryNotAdded,
  itemCategoryUpdated,
  itemCategoryNotUpdated,
  itemCategoryDeleted,
  itemCategoryNotDeleted,
  itemCategoryNotEmpty,
}

@injectable
class ItemCategoryManagementBloc
    extends Bloc<ItemCategoryManagementEvent, ItemCategoryManagementState> {
  final CompanyProfileBloc companyProfileBloc;
  final AddItemCategory addItemCategory;
  final UpdateItemCategory updateItemCategory;
  final DeleteItemCategory deleteItemCategory;

  late StreamSubscription _companyProfileStreamSubscription;
  String _companyId = '';

  ItemCategoryManagementBloc({
    required this.companyProfileBloc,
    required this.addItemCategory,
    required this.updateItemCategory,
    required this.deleteItemCategory,
  }) : super(ItemCategoryManagementEmptyState()) {
    _companyProfileStreamSubscription =
        companyProfileBloc.stream.listen((state) {
      if (state is CompanyProfileLoaded && _companyId.isEmpty) {
        _companyId = state.company.id;
      }
    });

    on<AddItemCategoryEvent>((event, emit) async {
      emit(ItemCategoryManagementLoadingState());
      final failureOrString = await addItemCategory(
        ItemCategoryParams(
          itemCategory: event.itemCategory,
          companyId: _companyId,
        ),
      );
      await failureOrString.fold(
        (failure) async => emit(
          ItemCategoryManagementErrorState(
            message: ItemCategoryMessage.itemCategoryNotAdded,
          ),
        ),
        (_) async => emit(
          ItemCategoryManagementSuccessState(
            message: ItemCategoryMessage.itemCategoryAdded,
          ),
        ),
      );
    });

    on<UpdateItemCategoryEvent>((event, emit) async {
      emit(ItemCategoryManagementLoadingState());
      final failureOrVoidResult = await updateItemCategory(
        ItemCategoryParams(
          itemCategory: event.itemCategory,
          companyId: _companyId,
        ),
      );
      await failureOrVoidResult.fold(
        (failure) async => emit(
          ItemCategoryManagementErrorState(
            message: ItemCategoryMessage.itemCategoryNotUpdated,
          ),
        ),
        (_) async => emit(
          ItemCategoryManagementSuccessState(
            message: ItemCategoryMessage.itemCategoryUpdated,
          ),
        ),
      );
    });

    on<DeleteItemCategoryEvent>((event, emit) async {
      emit(ItemCategoryManagementLoadingState());
      final failureOrVoidResult = await deleteItemCategory(
        ItemCategoryParams(
          itemCategory: event.itemCategory,
          companyId: _companyId,
        ),
      );
      await failureOrVoidResult.fold(
        (failure) async {
          if (failure is CategoryNotEmptyFailure) {
            emit(
              ItemCategoryManagementErrorState(
                message: ItemCategoryMessage.itemCategoryNotEmpty,
              ),
            );
          } else {
            emit(
              ItemCategoryManagementErrorState(
                message: ItemCategoryMessage.itemCategoryNotDeleted,
              ),
            );
          }
        },
        (_) async => emit(
          ItemCategoryManagementSuccessState(
            message: ItemCategoryMessage.itemCategoryDeleted,
          ),
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _companyProfileStreamSubscription.cancel();
    return super.close();
  }
}
