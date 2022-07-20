import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/group.dart';
import '../repositories/group_repository.dart';

class AddGroup extends FutureUseCase<String, Group> {
  final GroupRepository groupRepository;

  AddGroup({
    required this.groupRepository,
  });

  @override
  Future<Either<Failure, String>> call(Group params) async =>
      groupRepository.addGroup(params);
}
