part of 'work_request_cubit.dart';

abstract class WorkRequestCubitState extends Equatable {
  final List properties;
  const WorkRequestCubitState({this.properties = const []});

  @override
  List<Object> get props => [properties];
}

class WorkRequestCubitEmpty extends WorkRequestCubitState {}

class WorkRequestCubitError extends WorkRequestCubitState {}

class WorkRequestCubitLoading extends WorkRequestCubitState {}

class WorkRequestCubitLoaded extends WorkRequestCubitState {
  final WorkRequestModel workRequest;
  WorkRequestCubitLoaded({
    required this.workRequest,
  }) : super(properties: [workRequest]);
}
