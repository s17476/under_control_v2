import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/work_order/work_orders_stream.dart';
import '../../repositories/work_order_repository.dart';

@lazySingleton
class GetArchiveWorkOrdersStream
    extends FutureUseCase<WorkOrdersStream, ItemsInLocationsParams> {
  final WorkOrdersRepository repository;

  GetArchiveWorkOrdersStream({
    required this.repository,
  });

  @override
  Future<Either<Failure, WorkOrdersStream>> call(
    ItemsInLocationsParams params,
  ) async =>
      repository.getArchiveWorkOrdersStream(params);
}
