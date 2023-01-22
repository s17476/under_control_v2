part of 'item_category_bloc.dart';

abstract class ItemCategoryEvent extends Equatable {
  final List properties;

  const ItemCategoryEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetAllItemsCategoriesEvent extends ItemCategoryEvent {}

class ResetEvent extends ItemCategoryEvent {}

class UpdateItemsCategoriesListEvent extends ItemCategoryEvent {
  final QuerySnapshot<Object?> snapshot;
  UpdateItemsCategoriesListEvent({
    required this.snapshot,
  }) : super(properties: [snapshot]);
}
