import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/groups/domain/repositories/group_repository.dart';
import 'package:under_control_v2/features/groups/domain/usecases/add_group.dart';

class MockGroupRepository extends Mock implements GroupRepository {}

void main() {
  late AddGroup addGroup;
  late MockGroupRepository mockGroupRepository;
}
