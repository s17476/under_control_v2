import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/group_repository.dart';

class UpdateGroup extends FutureUseCase<VoidResult, GroupParams> {
  final GroupRepository groupRepository;

  UpdateGroup({
    required this.groupRepository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(GroupParams params) async =>
      groupRepository.updateGroup(params);
}
