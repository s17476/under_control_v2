import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/group_repository.dart';

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
