import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../../groups/domain/entities/feature.dart';
import '../../../../groups/domain/entities/group.dart';
import '../../../../locations/domain/entities/location.dart';
import '../../../data/models/items_list_model.dart';
import '../../../domain/entities/item.dart';
import '../../../domain/usecases/get_items_stream.dart';

part 'items_event.dart';
part 'items_state.dart';

@injectable
class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  late StreamSubscription filterStreamSubscription;
  StreamSubscription? itemsStreamSubscription;
  final FilterBloc filterBloc;
  final GetItemsStream getChecklistsStream;

  String companyId = '';

  ItemsBloc({
    required this.filterBloc,
    required this.getChecklistsStream,
  }) : super(ItemsEmptyState()) {
    filterStreamSubscription = filterBloc.stream.listen((state) {
      if (state is FilterLoadedState && companyId.isEmpty) {
        companyId = state.companyId;
        add(
          GetItemsEvent(
            companyId: companyId,
            selectedGroups: state.groups,
            selectedLocations: state.locations,
          ),
        );
      }
    });

    on<GetItemsEvent>((event, emit) async {
      emit(ItemsLoadingState());

      final failureOrItemsStream = await getChecklistsStream(
        ItemsInLocationsParams(
          locations: const [],
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
      (event, emit) async {
        emit(ItemsLoadingState());
        //   final availableLocations = getAvailableLocationsForGroups(
        //   groups: event.selectedGroups,
        //   locations: event.selectedLocations,
        // );
        final itemsList = ItemsListModel.fromSnapshot(
          event.snapshot as QuerySnapshot<Map<String, dynamic>>,
        );
        emit(
          ItemsLoadedState(allItems: itemsList),
        );
      },
    );
  }

  @override
  Future<void> close() {
    filterStreamSubscription.cancel();
    itemsStreamSubscription?.cancel();
    return super.close();
  }

  // gets only locations for the groups, with inventory read premission
  List<String> getAvailableLocationsForGroups({
    required List<Group> groups,
    required List<Location> locations,
  }) {
    List<String> availableLocations = [];

    for (var group in groups) {
      if (group.features
          .where((feature) =>
              (feature.type == FeatureType.inventory && feature.read))
          .isNotEmpty) {
        for (var location in group.locations) {
          if (locations.map((loc) => loc.id).contains(location) &&
              !availableLocations.contains(location)) {
            availableLocations.add(location);
          }
        }
      }
    }

    return availableLocations;
  }
}
