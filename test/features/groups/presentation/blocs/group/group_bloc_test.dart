import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/groups/data/models/group_model.dart';
import 'package:under_control_v2/features/groups/domain/entities/groups_list.dart';
import 'package:under_control_v2/features/groups/domain/entities/groups_stream.dart';
import 'package:under_control_v2/features/groups/domain/usecases/add_group.dart';
import 'package:under_control_v2/features/groups/domain/usecases/delete_group.dart';
import 'package:under_control_v2/features/groups/domain/usecases/get_groups_stream.dart';
import 'package:under_control_v2/features/groups/domain/usecases/update_group.dart';
import 'package:under_control_v2/features/groups/presentation/blocs/group/group_bloc.dart';

class MockCompanyProfileBloc extends Mock
    implements Stream<CompanyProfileState>, CompanyProfileBloc {}

class MockAddGroup extends Mock implements AddGroup {}

class MockUpdateGroup extends Mock implements UpdateGroup {}

class MockDeleteGroup extends Mock implements DeleteGroup {}

class MockGetGroupsStream extends Mock implements GetGroupsStream {}

void main() {
  late MockCompanyProfileBloc mockCompanyProfileBloc;
  late MockAddGroup mockAddGroup;
  late MockUpdateGroup mockUpdateGroup;
  late MockDeleteGroup mockDeleteGroup;
  late MockGetGroupsStream mockGetGroupsStream;
  late GroupBloc groupBloc;

  final tGroup = GroupModel.inital();

  setUpAll(() {
    registerFallbackValue(GroupParams(group: tGroup, companyId: 'comapnyId'));
  });

  setUp(() {
    mockCompanyProfileBloc = MockCompanyProfileBloc();
    mockAddGroup = MockAddGroup();
    mockUpdateGroup = MockUpdateGroup();
    mockDeleteGroup = MockDeleteGroup();
    mockGetGroupsStream = MockGetGroupsStream();

    when(() => mockCompanyProfileBloc.stream).thenAnswer(
      (_) => Stream.fromFuture(
        Future.value(CompanyProfileEmpty()),
      ),
    );

    groupBloc = GroupBloc(
      companyProfileBloc: mockCompanyProfileBloc,
      addGroup: mockAddGroup,
      updateGroup: mockUpdateGroup,
      deleteGroup: mockDeleteGroup,
      getGroupsStream: mockGetGroupsStream,
    );
  });

  group('Group BLoC', () {
    test('should emit [GroupEmptyState] as initial state', () async {
      // assert
      expect(groupBloc.state, GroupEmptyState());
    });

    group('[AddGroup] event', () {
      blocTest(
        'should emit [GroupErrorState] when AddGroup usecase returns failure',
        build: () => groupBloc,
        act: (GroupBloc bloc) async {
          bloc.add(AddGroupEvent(group: tGroup));
          when(() => mockAddGroup(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
        },
        expect: () => [isA<GroupErrorState>()],
      );

      blocTest<GroupBloc, GroupState>(
        'should emit [GroupLoadedState] when AddGroup usecase returns data',
        build: () => groupBloc,
        seed: () => GroupLoadedState(
          allGroups: const GroupsList(allGroups: []),
        ),
        act: (bloc) async {
          bloc.add(AddGroupEvent(group: tGroup));
          when(() => mockAddGroup(any()))
              .thenAnswer((_) async => const Right('groupId'));
        },
        expect: () => [isA<GroupLoadedState>()],
      );
    });

    group('[UpdateGroup] event', () {
      blocTest<GroupBloc, GroupState>(
        'should emit [GroupErrorState] when UpdateGroup usecase returns failure',
        build: () => groupBloc,
        seed: () => GroupLoadedState(
          allGroups: const GroupsList(allGroups: []),
        ),
        act: (bloc) async {
          bloc.add(UpdateGroupEvent(group: tGroup));
          when(() => mockUpdateGroup(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
        },
        expect: () => [isA<GroupErrorState>()],
      );

      blocTest<GroupBloc, GroupState>(
        'should emit [GroupLoadedState] when UpdateGroup usecase returns data',
        build: () => groupBloc,
        seed: () => GroupLoadedState(
          allGroups: const GroupsList(allGroups: []),
        ),
        act: (bloc) async {
          bloc.add(UpdateGroupEvent(group: tGroup));
          when(() => mockUpdateGroup(any()))
              .thenAnswer((_) async => Right(VoidResult()));
        },
        expect: () => [isA<GroupLoadedState>()],
      );
    });

    group('[DeleteGroup] event', () {
      blocTest<GroupBloc, GroupState>(
        'should emit [GroupErrorState] when DeleteGroup usecase returns failure',
        build: () => groupBloc,
        seed: () => GroupLoadedState(
          allGroups: const GroupsList(allGroups: []),
        ),
        act: (bloc) async {
          bloc.add(DeleteGroupEvent(group: tGroup));
          when(() => mockDeleteGroup(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
        },
        expect: () => [isA<GroupErrorState>()],
      );

      blocTest<GroupBloc, GroupState>(
        'should emit [GroupLoadedState] when deleteGroup usecase returns data',
        build: () => groupBloc,
        seed: () => GroupLoadedState(
          allGroups: const GroupsList(allGroups: []),
        ),
        act: (bloc) async {
          bloc.add(DeleteGroupEvent(group: tGroup));
          when(() => mockDeleteGroup(any()))
              .thenAnswer((_) async => Right(VoidResult()));
        },
        expect: () => [isA<GroupLoadedState>()],
      );
    });

    group('[FetchAllGroups] event', () {
      blocTest<GroupBloc, GroupState>(
        'should emit [GroupErrorState] when getGroupsStream usecase returns failure',
        build: () => groupBloc,
        act: (bloc) async {
          bloc.add(FetchAllGroupsEvent());
          when(() => mockGetGroupsStream(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
        },
        expect: () => [GroupLoadingState(), isA<GroupErrorState>()],
      );

      blocTest<GroupBloc, GroupState>(
        'should emit [GroupLoadedState] when getGroupsStream usecase returns data',
        build: () => groupBloc,
        act: (bloc) async {
          bloc.add(FetchAllGroupsEvent());
          when(() => mockGetGroupsStream(any())).thenAnswer((_) async =>
              Right(GroupsStream(allGroups: Stream.fromIterable([]))));
        },
        expect: () => [GroupLoadingState(), isA<GroupLoadedState>()],
      );
    });
  });
}
