import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/group_repository.dart';

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
