import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/work_order/work_orders_stream.dart';
import '../../repositories/work_order_repository.dart';

@lazySingleton
class GetWorkOrdersStream
    extends FutureUseCase<WorkOrdersStream, ItemsInLocationsParams> {
  final WorkOrdersRepository repository;

  GetWorkOrdersStream({
    required this.repository,
  });

  @override
  Future<Either<Failure, WorkOrdersStream>> call(
    ItemsInLocationsParams params,
  ) async =>
      repository.getWorkOrdersStream(params);
}
