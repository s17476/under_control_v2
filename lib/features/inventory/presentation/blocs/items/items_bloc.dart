import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist/checklist_bloc.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart';
import 'package:under_control_v2/features/groups/domain/entities/feature.dart';
import 'package:under_control_v2/features/groups/domain/entities/group.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/get_items_stream.dart';
import 'package:under_control_v2/features/locations/domain/entities/location.dart';
import 'package:under_control_v2/features/locations/presentation/blocs/bloc/location_bloc.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../data/models/items_list_model.dart';

part 'items_event.dart';
part 'items_state.dart';

@injectable
class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  late StreamSubscription filterStreamSubscription;
  StreamSubscription? itemsStreamSubscription;
  final FilterBloc filterBloc;
  final GetItemsStream getChecklistsStream;

  ItemsBloc({
    required this.filterBloc,
    required this.getChecklistsStream,
  }) : super(ItemsEmptyState()) {
    filterStreamSubscription = filterBloc.stream.listen((state) {
      if (state is FilterLoadedState && state.companyId.isNotEmpty) {
        add(
          GetItemsEvent(companyId: state.companyId, groups: state.groups),
        );
      }
    });

    on<GetItemsEvent>((event, emit) async {
      emit(ItemsLoadingState());

      final availableLocations = getAvailableLocations(groups: event.groups);

      final failureOrItemsStream = await getChecklistsStream(
        ItemsInLocationsParams(
          locations: availableLocations,
          companyId: event.companyId,
        ),
      );
      await failureOrItemsStream
          .fold((failure) async => emit(const ItemsErrorState()),
              (itemsStream) async {
        itemsStreamSubscription = itemsStream.allItems.listen((snapshot) {
          add(UpdateItemsListEvent(snapshot: snapshot));
        });
      });
    });

    on<UpdateItemsListEvent>(
      (event, emit) async {},
    );
  }

  @override
  Future<void> close() {
    filterStreamSubscription.cancel();
    itemsStreamSubscription?.cancel();
    return super.close();
  }

  // gets only locations for the groups, with inventory read premission
  List<String> getAvailableLocations({required List<Group> groups}) {
    List<String> availableLocations = [];
    for (var group in groups) {
      if (group.features
          .where((feature) =>
              (feature.type == FeatureType.inventory && feature.read))
          .isNotEmpty) {
        for (var location in group.locations) {
          if (!availableLocations.contains(location)) {
            availableLocations.add(location);
          }
        }
      }
    }
    print(availableLocations);
    return availableLocations;
  }
}
