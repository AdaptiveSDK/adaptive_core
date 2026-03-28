/// Thrown when the Adaptive SDK encounters a platform-level error.
class AdaptiveException implements Exception {
  /// A machine-readable error code (mirrors the Android SDK error codes).
  final String code;

  /// A human-readable description of the error.
  final String message;

  const AdaptiveException({required this.code, required this.message});

  @override
  String toString() => 'AdaptiveException[$code]: $message';
}
