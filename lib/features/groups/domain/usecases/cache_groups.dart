import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/core/error/failures.dart';

import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart';

@lazySingleton
class CacheGroups extends FutureUseCase<VoidResult, SelectedGroupsParams> {
  final GroupRepository groupRepository;

  CacheGroups({
    required this.groupRepository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(SelectedGroupsParams params) async =>
      groupRepository.cacheSelectedGroups(params);
}
