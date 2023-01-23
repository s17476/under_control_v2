import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/knowledge_base/data/models/inventory_category/instruction_category_model.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instruction_category/instructions_categories_stream.dart';
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart';
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_category/instruction_category_bloc.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

class MockUserProfileBloc extends Mock
    implements Stream<UserProfileState>, UserProfileBloc {}

class MockGetInstructionsCategoriesStream extends Mock
    implements GetInstructionsCategoriesStream {}

class MockAuthenticationBloc extends Mock
    implements Stream<AuthenticationState>, AuthenticationBloc {}

void main() {
  late MockAuthenticationBloc mockAuthenticationBloc;
  late MockUserProfileBloc mockUserProfileBloc;
  late MockGetInstructionsCategoriesStream mockGetInstructionsCategoriesStream;
  late InstructionCategoryBloc instructionCategoryBloc;

  const companyId = 'companyId';

  const tInstructionCategoryModel =
      InstructionCategoryModel(id: 'id', name: 'name');

  const tInstructioncategoryParams = InstructionCategoryParams(
    instructionCategory: tInstructionCategoryModel,
    companyId: companyId,
  );

  setUp(
    () {
      mockUserProfileBloc = MockUserProfileBloc();
      mockGetInstructionsCategoriesStream =
          MockGetInstructionsCategoriesStream();

      when(() => mockUserProfileBloc.stream).thenAnswer(
        (_) => Stream.fromFuture(
          Future.value(UserProfileEmpty()),
        ),
      );
      mockAuthenticationBloc = MockAuthenticationBloc();
      when(() => mockAuthenticationBloc.stream).thenAnswer(
        (_) => Stream.fromFuture(
          Future.value(EmptyAuthenticationState()),
        ),
      );

      instructionCategoryBloc = InstructionCategoryBloc(
        authenticationBloc: mockAuthenticationBloc,
        userProfileBloc: mockUserProfileBloc,
        getInstructionsCategoriesStream: mockGetInstructionsCategoriesStream,
      );
    },
  );

  setUpAll(
    () {
      registerFallbackValue(tInstructioncategoryParams);
    },
  );

  group('InstructionCategory BLoC', () {
    test(
      'should emit [InstructionCategoryEmptyState] as an initial state',
      () async {
        // assert
        expect(instructionCategoryBloc.state, InstructionCategoryEmptyState());
      },
    );

    group(
      'GetInstructionsCategoriesStream',
      () {
        blocTest<InstructionCategoryBloc, InstructionCategoryState>(
          'should emit [InstructionCategoryLoadingState]  when GetInstructionsCategoriesEvent is called',
          build: () => instructionCategoryBloc,
          act: (bloc) async {
            bloc.add(GetAllInstructionsCategoriesEvent());
            when(() => mockGetInstructionsCategoriesStream(any())).thenAnswer(
              (_) async => Right(
                InstructionsCategoriesStream(
                  allInstructionsCategories: Stream.fromIterable([]),
                ),
              ),
            );
          },
          expect: () => [
            InstructionCategoryLoadingState(),
          ],
        );
        blocTest<InstructionCategoryBloc, InstructionCategoryState>(
          'should emit [InstructionCategoryErrorState] when GetLAllInstructionsCategoriesEvent is called',
          build: () => instructionCategoryBloc,
          act: (bloc) async {
            bloc.add(GetAllInstructionsCategoriesEvent());
            when(() => mockGetInstructionsCategoriesStream(any())).thenAnswer(
              (_) async => const Left(
                DatabaseFailure(),
              ),
            );
          },
          expect: () => [
            InstructionCategoryLoadingState(),
            isA<InstructionCategoryErrorState>(),
          ],
        );
      },
    );
  });
}
