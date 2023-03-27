class ServerException implements Exception {}

class CacheException implements Exception {}

class DeleteException implements Exception {
  final String message;

  const DeleteException({
    required this.message,
  });
}
