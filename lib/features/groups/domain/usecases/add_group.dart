import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/core/error/failures.dart';

import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/groups/domain/entities/group.dart';
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart';

class AddGroup extends FutureUseCase<String, Group> {
  final GroupRepository groupRepository;

  AddGroup({
    required this.groupRepository,
  });

  @override
  Future<Either<Failure, String>> call(Group params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
