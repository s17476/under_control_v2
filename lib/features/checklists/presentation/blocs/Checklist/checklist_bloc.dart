import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../data/models/checklists_list_model.dart';
import '../../../domain/usecases/get_checklists_stream.dart';

part 'checklist_event.dart';
part 'checklist_state.dart';

@injectable
class ChecklistBloc extends Bloc<ChecklistEvent, ChecklistState> {
  late StreamSubscription _companyProfileStreamSubscription;
  StreamSubscription? _checklistsStreamSubscription;
  final CompanyProfileBloc companyProfileBloc;
  final GetChecklistStream getChecklistsStream;

  String companyId = '';

  ChecklistBloc({
    required this.companyProfileBloc,
    required this.getChecklistsStream,
  }) : super(ChecklistEmptyState()) {
    _companyProfileStreamSubscription =
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
        _checklistsStreamSubscription =
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
    _companyProfileStreamSubscription.cancel();
    _checklistsStreamSubscription?.cancel();
    return super.close();
  }
}
