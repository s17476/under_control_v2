import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/checklists/data/models/checklists_list_model.dart';
import 'package:under_control_v2/features/checklists/domain/usecases/get_checklists_stream.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';

part 'checklist_event.dart';
part 'checklist_state.dart';

@lazySingleton
class ChecklistBloc extends Bloc<ChecklistEvent, ChecklistState> {
  late StreamSubscription companyProfileStreamSubscription;
  StreamSubscription? checklistsStreamSubscription;
  final CompanyProfileBloc companyProfileBloc;
  final GetChecklistStream getChecklistsStream;

  String companyId = '';

  ChecklistBloc({
    required this.companyProfileBloc,
    required this.getChecklistsStream,
  }) : super(ChecklistEmptyState()) {
    companyProfileStreamSubscription =
        companyProfileBloc.stream.listen((state) {
      if (state is CompanyProfileLoaded && companyId.isEmpty) {
        companyId = state.company.id;
        add(GetAllChecklistsEvent());
      }
    });

    on<GetAllChecklistsEvent>((event, emit) async {
      emit(ChecklistLoadingState());

      final failureOrChecklistsStream = await getChecklistsStream(companyId);
      await failureOrChecklistsStream.fold(
          (failure) async =>
              emit(ChecklistErrorState(message: failure.message)),
          (checklistsStream) async {
        checklistsStreamSubscription =
            checklistsStream.allChecklists.listen((snapshot) {
          add(UpdateChecklistsListEvent(snapshot: snapshot));
        });
      });
    });

    on<UpdateChecklistsListEvent>(
      (event, emit) async {
        emit(ChecklistLoadingState());
        final checklistsList = ChecklistsListModel.fromSnapshot(
          event.snapshot as QuerySnapshot<Map<String, dynamic>>,
        );
        emit(ChecklistLoadedState(allChecklists: checklistsList));
      },
    );
  }

  @override
  Future<void> close() {
    companyProfileStreamSubscription.cancel();
    checklistsStreamSubscription?.cancel();
    return super.close();
  }
}
