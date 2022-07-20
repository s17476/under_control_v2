import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/group_repository.dart';

class DeleteGroup extends FutureUseCase<VoidResult, String> {
  final GroupRepository groupRepository;

  DeleteGroup({
    required this.groupRepository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(String params) async =>
      groupRepository.deleteGroup(params);
}
