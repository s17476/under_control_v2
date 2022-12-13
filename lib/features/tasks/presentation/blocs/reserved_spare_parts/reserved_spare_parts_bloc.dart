import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/tasks/data/models/task/spare_part_item_model.dart';

part 'reserved_spare_parts_event.dart';
part 'reserved_spare_parts_state.dart';

@injectable
class ReservedSparePartsBloc
    extends Bloc<ReservedSparePartsEvent, ReservedSparePartsState> {
  ReservedSparePartsBloc() : super(const ReservedSparePartsEmptyState()) {
    on<ReservedSparePartsResetEvent>((event, emit) {
      emit(const ReservedSparePartsEmptyState());
    });
    on<ReservedSparePartsUpdateEvent>((event, emit) {
      emit(ReservedSparePartsActiveState(spareParts: event.spareParts));
    });
  }
}
