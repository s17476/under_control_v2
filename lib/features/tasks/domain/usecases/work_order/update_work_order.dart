import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/work_order_repository.dart';

@lazySingleton
class UpdateWorkOrder extends FutureUseCase<VoidResult, WorkOrderParams> {
  final WorkOrdersRepository repository;

  UpdateWorkOrder({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(WorkOrderParams params) async =>
      repository.updateWorkOrder(params);
}
