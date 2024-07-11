class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = '']);

  @override
  String toString() {
    return message.isNotEmpty ? 'CacheException: $message' : 'CacheException';
  }
}

class SocketException implements Exception {
  final String message;

  SocketException({required this.message});
}

class PaymentException implements Exception {
  final String message;

  PaymentException({required this.message});
}
