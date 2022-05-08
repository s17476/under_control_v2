import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:injectable/injectable.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker dataConnectionChecker;
  NetworkInfoImpl({
    required this.dataConnectionChecker,
  });

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;
}
