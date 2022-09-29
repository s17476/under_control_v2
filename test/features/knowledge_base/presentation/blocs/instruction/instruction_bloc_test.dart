import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instructions_stream.dart';
import 'package:under_control_v2/features/knowledge_base/domain/usecases/get_instructions_stream.dart';
import 'package:under_control_v2/features/knowledge_base/presentation/blocs/instruction/instruction_bloc.dart';

class MockFilterBloc extends Mock implements Stream<FilterState>, FilterBloc {}

class MockGetInstructionsStream extends Mock implements GetInstructionsStream {}

void main() {
  late MockFilterBloc mockFilterBloc;

  late MockGetInstructionsStream mockGetInstructionsStream;

  late InstructionBloc instructionBloc;

  setUp(
    () {
      mockFilterBloc = MockFilterBloc();

      when(() => mockFilterBloc.stream).thenAnswer(
        (_) => Stream.fromFuture(
          Future.value(
            FilterEmptyState(),
          ),
        ),
      );
      when(() => mockFilterBloc.state).thenAnswer(
        (_) => FilterEmptyState(),
      );

      mockGetInstructionsStream = MockGetInstructionsStream();

      instructionBloc = InstructionBloc(
        filterBloc: mockFilterBloc,
        getInstructionsStream: mockGetInstructionsStream,
      );
    },
  );

  setUpAll(
    () {
      registerFallbackValue(
        const InstructionsInLocationsParams(
          locations: ['loc1', 'loc2'],
          companyId: 'companyId',
        ),
      );
    },
  );

  group('Instruction BLoC', () {
    test(
      'should emit [InstructionEmptyState] as initial state',
      () async {
        // assert
        expect(instructionBloc.state, isA<InstructionEmptyState>());
      },
    );

    group('GetInstructionsStream', () {
      blocTest<InstructionBloc, InstructionState>(
        'should emit [InstructionLoadedState] when GetInstructionsStream is called',
        build: () => instructionBloc,
        act: (bloc) async {
          bloc.add(GetInstructionsStreamEvent());
          when(() => mockGetInstructionsStream(any())).thenAnswer(
            (_) async => Right(
              InstructionsStream(
                allInstructions: Stream.fromIterable([]),
              ),
            ),
          );
        },
        expect: () => [isA<InstructionLoadedState>()],
      );

      // blocTest<InstructionBloc, InstructionState>(
      //   'should emit [instructionErrorState]  when GetInstructionsStreamEvent is called',
      //   build: () => instructionBloc,
      //   act: (bloc) async {
      //     bloc.add(GetInstructionsStreamEvent());
      //     when(() => mockGetInstructionsStream(any())).thenAnswer(
      //       (_) async => const Left(
      //         DatabaseFailure(),
      //       ),
      //     );
      //   },
      //   expect: () => [isA<InstructionErrorState>()],
      // );
    });
  });
}
