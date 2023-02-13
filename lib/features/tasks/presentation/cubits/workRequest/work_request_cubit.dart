import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/work_request/work_request_model.dart';
import '../../../domain/usecases/work_order/get_work_request_by_id.dart';

part 'work_request_state.dart';

@injectable
class WorkRequestCubit extends Cubit<WorkRequestCubitState> {
  final UserProfileBloc userProfileBloc;
  final GetWorkRequestById getWorkRequestByIdUsecase;
  WorkRequestCubit({
    required this.userProfileBloc,
    required this.getWorkRequestByIdUsecase,
  }) : super(WorkRequestCubitEmpty());

  Future<void> getWorkRequestById(String workRequestId) async {
    emit(WorkRequestCubitLoading());
    final userState = userProfileBloc.state;
    if (userState is Approved) {
      final params = IdParams(
        companyId: userState.userProfile.companyId,
        id: workRequestId,
      );
      final failureOrWorkRequest = await getWorkRequestByIdUsecase(params);
      await failureOrWorkRequest.fold(
        (failure) async => emit(WorkRequestCubitError()),
        (task) async => emit(WorkRequestCubitLoaded(workRequest: task)),
      );
    }
  }
}
