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
  final FilterBloc filterBloc;
  final GetItemsStream getChecklistsStream;

  late StreamSubscription _filterStreamSubscription;
  StreamSubscription? _itemsStreamSubscription;
  String _companyId = '';

  ItemsBloc({
    required this.filterBloc,
    required this.getChecklistsStream,
  }) : super(ItemsEmptyState()) {
    _filterStreamSubscription = filterBloc.stream.listen((state) {
      if (state is FilterLoadedState && _companyId.isEmpty) {
        _companyId = state.companyId;
        add(
          GetItemsEvent(
            companyId: _companyId,
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
        _itemsStreamSubscription = itemsStream.allItems.listen((snapshot) {
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
    _filterStreamSubscription.cancel();
    _itemsStreamSubscription?.cancel();
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
