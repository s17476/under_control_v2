import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/work_order_repository.dart';

@lazySingleton
class AddWorkOrder extends FutureUseCase<String, WorkOrderParams> {
  final WorkOrdersRepository repository;

  AddWorkOrder({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(WorkOrderParams params) async =>
      repository.addWorkOrder(params);
}
