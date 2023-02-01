import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_new_users.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/new_users/new_users_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';

class MockFetchNewUsers extends Mock implements FetchNewUsers {}

class MockCompanyProfileBloc extends Mock implements CompanyProfileBloc {}

void main() {
  late NewUsersBloc newUsersBloc;
  late MockFetchNewUsers mockFetchNewUsers;
  late MockCompanyProfileBloc mockCompanyProfileBloc;

  setUp(
    () {
      mockFetchNewUsers = MockFetchNewUsers();
      mockCompanyProfileBloc = MockCompanyProfileBloc();
      when(
        () => mockCompanyProfileBloc.stream,
      ).thenAnswer(
        (_) => Stream.fromFuture(
          Future.value(
            CompanyProfileEmpty(),
          ),
        ),
      );
      newUsersBloc = NewUsersBloc(
        mockCompanyProfileBloc,
        mockFetchNewUsers,
      );
    },
  );

  group('NewUsersBloc', () {
    test(
      'should emit [NewUsersEmptyState]',
      () async {
        // assert
        expect(newUsersBloc.state, NewUsersEmptyState());
      },
    );

    group('FetchNewUsers', () {
      // blocTest<NewUsersBloc, NewUsersState>(
      //   'should emit [NewUsersLoadedState] when fetchNewUsers returns data',
      //   build: () => newUsersBloc,
      //   act: (bloc) async {
      //     when(() => mockFetchNewUsers(any()))
      //         .thenAnswer((_) async => Right(tCompanyUsers));
      //     bloc.add(
      //       FetchNewUsersEvent(companyId: 'companyId'),
      //     );
      //   },
      //   skip: 1,
      //   expect: () => [isA<NewUsersLoadedState>()],
      // );
      blocTest<NewUsersBloc, NewUsersState>(
        'should emit [NewUsersErrorState] when fetchNewUsers returns failure',
        build: () => newUsersBloc,
        act: (bloc) async {
          bloc.add(
            FetchNewUsersEvent(companyId: 'companyId'),
          );
          when(() => mockFetchNewUsers(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
        },
        skip: 1,
        expect: () => [isA<NewUsersErrorState>()],
      );
    });
  });
}
