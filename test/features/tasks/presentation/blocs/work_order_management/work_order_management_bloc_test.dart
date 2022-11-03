import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/tasks/data/models/work_order/work_order_model.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_priority.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/add_work_order.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/delete_work_order.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/update_work_order.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/work_order_management/work_order_management_bloc.dart';

class MockCompanyProfileBloc extends Mock
    implements Stream<CompanyProfileState>, CompanyProfileBloc {}

class MockAddWorkOrder extends Mock implements AddWorkOrder {}

class MockDeleteWorkOrder extends Mock implements DeleteWorkOrder {}

class MockUpdateWorkOrder extends Mock implements UpdateWorkOrder {}

void main() {
  late MockCompanyProfileBloc mockCompanyProfileBloc;

  late MockAddWorkOrder mockAddWorkOrder;
  late MockDeleteWorkOrder mockDeleteWorkOrder;
  late MockUpdateWorkOrder mockUpdateWorkOrder;

  late WorkOrderManagementBloc workOrderManagementBloc;

  const companyId = 'companyId';

  final tWorkOrderModel = WorkOrderModel(
    id: 'id',
    title: 'title',
    description: 'description',
    date: DateTime.now(),
    locationId: 'locationId',
    userId: 'userId',
    assetId: 'assetId',
    images: const [],
    video: 'video',
    priority: TaskPriority.low,
    count: 0,
  );

  final tWorkOrderParams = WorkOrderParams(
    workOrder: tWorkOrderModel,
    companyId: companyId,
  );

  setUp(() {
    mockCompanyProfileBloc = MockCompanyProfileBloc();

    mockAddWorkOrder = MockAddWorkOrder();
    mockDeleteWorkOrder = MockDeleteWorkOrder();
    mockUpdateWorkOrder = MockUpdateWorkOrder();

    when(() => mockCompanyProfileBloc.stream).thenAnswer(
      (_) => Stream.fromFuture(
        Future.value(CompanyProfileEmpty()),
      ),
    );

    workOrderManagementBloc = WorkOrderManagementBloc(
      companyProfileBloc: mockCompanyProfileBloc,
      addWorkOrder: mockAddWorkOrder,
      deleteWorkOrder: mockDeleteWorkOrder,
      updateWorkOrder: mockUpdateWorkOrder,
    );
  });

  setUpAll(() {
    registerFallbackValue(tWorkOrderParams);
  });

  group('Work Order Management BLoC', () {
    test(
      'should emit [WorkOrderManagementEmptyState] as an initial state',
      () async {
        // assert
        expect(workOrderManagementBloc.state, WorkOrderManagementEmptyState());
      },
    );

    group('AddWorkOrder', () {
      blocTest<WorkOrderManagementBloc, WorkOrderManagementState>(
        'should emit [WorkOrderManagementSuccessfulStete]',
        build: () => workOrderManagementBloc,
        act: (bloc) async {
          when(() => mockAddWorkOrder(any()))
              .thenAnswer((_) async => const Right(''));
          bloc.add(AddWorkOrderEvent(workOrder: tWorkOrderModel));
        },
        expect: () => [
          WorkOrderManagementLoadingState(),
          isA<WorkOrderManagementSuccessState>(),
        ],
      );
      blocTest<WorkOrderManagementBloc, WorkOrderManagementState>(
        'should emit [WorkOrderManagementErrorStete]',
        build: () => workOrderManagementBloc,
        act: (bloc) async {
          when(() => mockAddWorkOrder(any())).thenAnswer(
            (_) async => const Left(
              DatabaseFailure(),
            ),
          );
          bloc.add(AddWorkOrderEvent(workOrder: tWorkOrderModel));
        },
        expect: () => [
          WorkOrderManagementLoadingState(),
          isA<WorkOrderManagementErrorState>(),
        ],
      );
    });
    group('DeleteWorkOrder', () {
      blocTest<WorkOrderManagementBloc, WorkOrderManagementState>(
        'should emit [WorkOrderManagementSuccessfulStete]',
        build: () => workOrderManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteWorkOrder(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(DeleteWorkOrderEvent(workOrder: tWorkOrderModel));
        },
        expect: () => [
          WorkOrderManagementLoadingState(),
          isA<WorkOrderManagementSuccessState>(),
        ],
      );
      blocTest<WorkOrderManagementBloc, WorkOrderManagementState>(
        'should emit [WorkOrderManagementErrorStete]',
        build: () => workOrderManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteWorkOrder(any())).thenAnswer(
            (_) async => const Left(
              DatabaseFailure(),
            ),
          );
          bloc.add(DeleteWorkOrderEvent(workOrder: tWorkOrderModel));
        },
        expect: () => [
          WorkOrderManagementLoadingState(),
          isA<WorkOrderManagementErrorState>(),
        ],
      );
    });
    group('UpdateWorkOrder', () {
      blocTest<WorkOrderManagementBloc, WorkOrderManagementState>(
        'should emit [WorkOrderManagementSuccessfulStete]',
        build: () => workOrderManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateWorkOrder(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(UpdateWorkOrderEvent(workOrder: tWorkOrderModel));
        },
        expect: () => [
          WorkOrderManagementLoadingState(),
          isA<WorkOrderManagementSuccessState>(),
        ],
      );
      blocTest<WorkOrderManagementBloc, WorkOrderManagementState>(
        'should emit [WorkOrderManagementErrorStete]',
        build: () => workOrderManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateWorkOrder(any())).thenAnswer(
            (_) async => const Left(
              DatabaseFailure(),
            ),
          );
          bloc.add(UpdateWorkOrderEvent(workOrder: tWorkOrderModel));
        },
        expect: () => [
          WorkOrderManagementLoadingState(),
          isA<WorkOrderManagementErrorState>(),
        ],
      );
    });
  });
}
