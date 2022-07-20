import 'package:dartz/dartz.dart';
import 'package:under_control_v2/features/groups/domain/entities/groups_stream.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/group_repository.dart';

class GetGroupsStream extends FutureUseCase<GroupsStream, String> {
  final GroupRepository groupRepository;

  GetGroupsStream({
    required this.groupRepository,
  });

  @override
  Future<Either<Failure, GroupsStream>> call(String params) async =>
      groupRepository.getGroupsStream(params);
}
