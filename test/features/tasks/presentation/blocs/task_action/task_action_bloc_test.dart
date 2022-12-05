import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/get_task_actions_stream.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action/task_action_bloc.dart';

import '../../../t_task_instance.dart';

class MockGetTaskActionsStream extends Mock implements GetTaskActionsStream {}

void main() {
  late MockGetTaskActionsStream mockGetTaskActionsStream;
  late TaskActionBloc taskActionBloc;

  setUp(() {
    mockGetTaskActionsStream = MockGetTaskActionsStream();
    taskActionBloc = TaskActionBloc(
      getTaskActionsStream: mockGetTaskActionsStream,
    );
  });

  setUpAll(() {
    registerFallbackValue(tTaskParams);
  });

  group('TaskAction BLoC', () {
    test(
      'should emit [TaskActionEmptyState] as an initial state',
      () async {
        // assert
        expect(taskActionBloc.state, TaskActionEmptyState());
      },
    );

    group('ResetTaskActionsEvent', () {
      blocTest<TaskActionBloc, TaskActionState>(
        'should emit [TaskActionEmptyState] when ResetTaskAction is called',
        build: () => taskActionBloc,
        act: (bloc) async {
          bloc.add(ResetTaskActionsEvent());
        },
        expect: () => [TaskActionEmptyState()],
      );
    });

    // group('GetTaskActionsStream', () {
    //   blocTest<TaskActionBloc, TaskActionState>(
    //     'should emit [TaskActionLoadedState] when GetTaskActionsStream is called',
    //     build: () => taskActionBloc,
    //     act: (bloc) {
    //       bloc.add(
    //         GetTaskActionsForTaskStreamEvent(
    //           task: tTaskModel,
    //           companyId: 'companyId',
    //         ),
    //       );
    //       when(
    //         () => mockGetTaskActionsStream(any()),
    //       ).thenAnswer(
    //         (_) async => right(
    //           TaskActionsStreamModel(
    //             allTaskActions: Stream.fromIterable(
    //               [],
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //     expect: () => [isA<TaskActionLoadedState>()],
    //   );
    // });
  });
}
