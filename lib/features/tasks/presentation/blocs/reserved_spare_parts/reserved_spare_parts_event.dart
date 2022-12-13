part of 'reserved_spare_parts_bloc.dart';

abstract class ReservedSparePartsEvent extends Equatable {
  const ReservedSparePartsEvent({this.properties = const []});
  final List properties;

  @override
  List<Object> get props => [properties];
}

class ReservedSparePartsResetEvent extends ReservedSparePartsEvent {}

class ReservedSparePartsUpdateEvent extends ReservedSparePartsEvent {
  final List<SparePartItemModel> spareParts;
  ReservedSparePartsUpdateEvent({
    required this.spareParts,
  }) : super(properties: [spareParts]);
}
