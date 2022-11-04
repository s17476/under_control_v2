import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/work_order_repository.dart';

@lazySingleton
class CancelWorkOrder extends FutureUseCase<VoidResult, WorkOrderParams> {
  final WorkOrdersRepository repository;

  CancelWorkOrder({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(WorkOrderParams params) async =>
      repository.cancelWorkOrder(params);
}
