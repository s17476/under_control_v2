import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/groups/domain/entities/feature.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../data/models/instructions_list_model.dart';
import '../../../domain/entities/instruction.dart';
import '../../../domain/usecases/get_instructions_stream.dart';

part 'instruction_event.dart';
part 'instruction_state.dart';

@injectable
class InstructionBloc extends Bloc<InstructionEvent, InstructionState> {
  final FilterBloc filterBloc;
  final GetInstructionsStream getInstructionsStream;

  late StreamSubscription _filterStreamSubscription;
  final List<StreamSubscription?> _instructionStreamSubscriptions = [];

  String _companyId = '';
  List<String> _locations = [];

  InstructionBloc({
    required this.filterBloc,
    required this.getInstructionsStream,
  }) : super(InstructionEmptyState()) {
    _filterStreamSubscription = filterBloc.stream.listen(
      (state) {
        if (state is FilterLoadedState) {
          if (_instructionStreamSubscriptions.isNotEmpty) {
            // cancel old subscriptions
            for (var actionSubscription in _instructionStreamSubscriptions) {
              actionSubscription?.cancel();
            }
            // clear subscriptions list
            _instructionStreamSubscriptions.clear();
          }

          _companyId = state.companyId;
          if (state.isAdmin && state.groups.isEmpty) {
            _locations = state.locations.map((loc) => loc.id).toList();
          } else {
            _locations = state
                .getAvailableLocations(FeatureType.knowledgeBase)
                .map((loc) => loc.id)
                .toList();
          }

          add(GetInstructionsStreamEvent());
        }
      },
    );

    on<GetInstructionsStreamEvent>((event, emit) async {
      if (_locations.isEmpty) {
        emit(
          InstructionLoadedState(
            allInstructions: const InstructionsListModel(
              allInstructions: [],
            ),
          ),
        );
      } else {
        emit(InstructionLoadingState());
        if (_instructionStreamSubscriptions.isNotEmpty) {
          // cancel old subscriptions
          for (var actionSubscription in _instructionStreamSubscriptions) {
            actionSubscription?.cancel();
          }
          // clear subscriptions list
          _instructionStreamSubscriptions.clear();
        }

        final List<List<String>> chunkedLocations = [];
        // chunks list size, because of DB limitations
        int chunkSize = 10;
        for (var i = 0; i < _locations.length; i += chunkSize) {
          chunkedLocations.add(
            _locations.sublist(
              i,
              i + chunkSize > _locations.length
                  ? _locations.length
                  : i + chunkSize,
            ),
          );
        }
        for (int j = 0; j < chunkedLocations.length; j++) {
          var chunk = chunkedLocations[j];
          final params = InstructionsInLocationsParams(
            locations: chunk,
            companyId: _companyId,
          );

          final failureOrInstructionssStream =
              await getInstructionsStream(params);
          await failureOrInstructionssStream.fold(
            (failure) async =>
                emit(InstructionErrorState(message: failure.message)),
            (instructionsStream) async {
              final streamSubscription =
                  instructionsStream.allInstructions.listen((snapshot) {
                add(UpdateInstructionsListEvent(
                  snapshot: snapshot,
                  locations: chunk,
                ));
              });
              _instructionStreamSubscriptions.add(streamSubscription);
            },
          );
        }
      }
    });

    on<UpdateInstructionsListEvent>((event, emit) async {
      List<Instruction>? oldInstructions;
      // save old instructions if this is not a first chunk
      if (state is InstructionLoadedState) {
        oldInstructions =
            (state as InstructionLoadedState).allInstructions.allInstructions;
      }
      emit(InstructionLoadingState());
      // gets instructions list
      InstructionsListModel instructionsList =
          InstructionsListModel.fromSnapshot(
        event.snapshot as QuerySnapshot<Map<String, dynamic>>,
      );

      // merge instructions list if this is not a first chunk
      if (oldInstructions != null) {
        List<Instruction> instructionsToRemove = [];
        for (var oldInstruction in oldInstructions) {
          if (oldInstruction.locations.any(
            (inst) => event.locations.contains(inst),
          )) {
            instructionsToRemove.add(oldInstruction);
          }
        }
        for (var instructionToRemove in instructionsToRemove) {
          oldInstructions.remove(instructionToRemove);
        }
        // merge and sort by name
        List<Instruction> tmpList = [
          ...oldInstructions,
          ...instructionsList.allInstructions,
        ]..sort((a, b) => a.name.compareTo(b.name));

        instructionsList = InstructionsListModel(
          allInstructions: tmpList,
        );
      }
      emit(InstructionLoadedState(
        allInstructions: instructionsList,
      ));
    });
  }

  @override
  Future<void> close() {
    _filterStreamSubscription.cancel();
    if (_instructionStreamSubscriptions.isNotEmpty) {
      for (var actionSubscription in _instructionStreamSubscriptions) {
        actionSubscription?.cancel();
      }
    }
    return super.close();
  }
}
