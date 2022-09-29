import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/knowledge_base/data/models/instruction_model.dart';
import 'package:under_control_v2/features/knowledge_base/domain/usecases/add_instruction.dart';
import 'package:under_control_v2/features/knowledge_base/domain/usecases/delete_instruction.dart';
import 'package:under_control_v2/features/knowledge_base/domain/usecases/update_instruction.dart';
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart';

class MockCompanyProfileBloc extends Mock
    implements Stream<CompanyProfileState>, CompanyProfileBloc {}

class MockAddInstruction extends Mock implements AddInstruction {}

class MockDeleteInstruction extends Mock implements DeleteInstruction {}

class MockUpdateInstruction extends Mock implements UpdateInstruction {}

void main() {
  late MockCompanyProfileBloc mockCompanyProfileBloc;

  late MockAddInstruction mockAddInstruction;
  late MockDeleteInstruction mockDeleteInstruction;
  late MockUpdateInstruction mockUpdateInstruction;

  late InstructionManagementBloc instructionManagementBloc;

  const companyId = 'companyId';

  InstructionModel tInstructionModel = const InstructionModel(
    id: 'id',
    name: 'name',
    description: 'description',
    category: 'category',
    steps: [],
    locations: [],
    userId: 'userId',
    lastEdited: [],
    isPublished: true,
  );

  InstructionParams tInstructionParams = InstructionParams(
    instruction: tInstructionModel,
    companyId: companyId,
  );

  setUp(
    () {
      mockCompanyProfileBloc = MockCompanyProfileBloc();

      when(() => mockCompanyProfileBloc.stream).thenAnswer(
        (_) => Stream.fromFuture(
          Future.value(CompanyProfileEmpty()),
        ),
      );

      mockAddInstruction = MockAddInstruction();
      mockDeleteInstruction = MockDeleteInstruction();
      mockUpdateInstruction = MockUpdateInstruction();

      instructionManagementBloc = InstructionManagementBloc(
        companyProfileBloc: mockCompanyProfileBloc,
        addInstruction: mockAddInstruction,
        deleteInstruction: mockDeleteInstruction,
        updateInstruction: mockUpdateInstruction,
      );
    },
  );

  setUpAll(
    () {
      registerFallbackValue(tInstructionParams);
    },
  );

  group('InstructionManagement BLoC', () {
    test(
      'should emit [InstructionManagementEmptyState] as an initial state',
      () async {
        // assert
        expect(instructionManagementBloc.state,
            isA<InstructionManagementEmptyState>());
      },
    );

    group('AddInstructionEvent', () {
      blocTest<InstructionManagementBloc, InstructionManagementState>(
        'should emit [InstructionManagementSuccessfulState] when AddInstruction is called',
        build: () => instructionManagementBloc,
        act: (bloc) async {
          when(() => mockAddInstruction(any())).thenAnswer(
            (_) async => const Right(''),
          );
          bloc.add(AddInstructionEvent(instruction: tInstructionModel));
        },
        expect: () => [
          InstructionManagementLoadingState(),
          isA<InstructionManagementSuccessState>(),
        ],
      );
      blocTest<InstructionManagementBloc, InstructionManagementState>(
        'should emit [InstructionManagementErrorState] when AddInstruction is called',
        build: () => instructionManagementBloc,
        act: (bloc) async {
          when(() => mockAddInstruction(any())).thenAnswer(
            (_) async => const Left(DatabaseFailure()),
          );
          bloc.add(AddInstructionEvent(instruction: tInstructionModel));
        },
        expect: () => [
          InstructionManagementLoadingState(),
          isA<InstructionManagementErrorState>(),
        ],
      );
    });

    group('DeleteInstructionEvent', () {
      blocTest<InstructionManagementBloc, InstructionManagementState>(
        'should emit [InstructionManagementSuccessfulState] when DeleteInstruction is called',
        build: () => instructionManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteInstruction(any())).thenAnswer(
            (_) async => Right(VoidResult()),
          );
          bloc.add(DeleteInstructionEvent(instruction: tInstructionModel));
        },
        expect: () => [
          InstructionManagementLoadingState(),
          isA<InstructionManagementSuccessState>(),
        ],
      );
      blocTest<InstructionManagementBloc, InstructionManagementState>(
        'should emit [InstructionManagementErrorState] when DeleteInstruction is called',
        build: () => instructionManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteInstruction(any())).thenAnswer(
            (_) async => const Left(DatabaseFailure()),
          );
          bloc.add(DeleteInstructionEvent(instruction: tInstructionModel));
        },
        expect: () => [
          InstructionManagementLoadingState(),
          isA<InstructionManagementErrorState>(),
        ],
      );
    });

    group('UpdateInstructionEvent', () {
      blocTest<InstructionManagementBloc, InstructionManagementState>(
        'should emit [InstructionManagementSuccessfulState] when UpdateInstruction is called',
        build: () => instructionManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateInstruction(any())).thenAnswer(
            (_) async => Right(VoidResult()),
          );
          bloc.add(UpdateInstructionEvent(instruction: tInstructionModel));
        },
        expect: () => [
          InstructionManagementLoadingState(),
          isA<InstructionManagementSuccessState>(),
        ],
      );
      blocTest<InstructionManagementBloc, InstructionManagementState>(
        'should emit [InstructionManagementErrorState] when UpdateInstruction is called',
        build: () => instructionManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateInstruction(any())).thenAnswer(
            (_) async => const Left(DatabaseFailure()),
          );
          bloc.add(UpdateInstructionEvent(instruction: tInstructionModel));
        },
        expect: () => [
          InstructionManagementLoadingState(),
          isA<InstructionManagementErrorState>(),
        ],
      );
    });
  });
}
