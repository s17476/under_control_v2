import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart';

@lazySingleton
class TryToGetCachedGroups
    extends FutureUseCase<SelectedGroupsParams, NoParams> {
  final GroupRepository groupRepository;

  TryToGetCachedGroups({
    required this.groupRepository,
  });

  @override
  Future<Either<Failure, SelectedGroupsParams>> call(NoParams params) async =>
      groupRepository.tryToGetCachedgroups();
}
