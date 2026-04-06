import 'package:flutter/services.dart';
import 'adaptive_user.dart';
import 'adaptive_exception.dart';

/// The main entry point for the Adaptive Core SDK.
///
/// You must call [initialize] once before using any other SDK feature.
///
/// ```dart
/// await AdaptiveCore.initialize(clientId: 'your-client-id', debug: true);
/// await AdaptiveCore.login(
///   userId: '1234',
///   userName: 'John Doe',
///   userEmail: 'john@example.com',
/// );
/// ```
class AdaptiveCore {
  static final MethodChannel _channel = MethodChannel('adaptive_core');

  AdaptiveCore._();

  /// Initializes the Adaptive SDK.
  ///
  /// Must be called once — typically in `main()` or your app's init logic —
  /// before calling any other Adaptive SDK method.
  ///
  /// [clientId] — your organization's API key provided by Adaptive.
  /// [debug]    — enables verbose logging when `true` (default: `false`).
  ///
  /// Throws [AdaptiveException] on failure.
  static Future<void> initialize({
    required String clientId,
    bool debug = false,
  }) async {
    try {
      await _channel.invokeMethod<void>('initialize', {
        'clientId': clientId,
        'debug': debug,
      });
    } on PlatformException catch (e) {
      throw AdaptiveException(code: e.code, message: e.message ?? '');
    }
  }

  /// Logs a user in to the SDK session.
  ///
  /// Must be called after [initialize]. The user object is attached to every
  /// subsequent analytics and messaging payload automatically.
  ///
  /// Throws [AdaptiveException] on failure.
  static Future<void> login(AdaptiveUser user) async {
    try {
      await _channel.invokeMethod<void>('login', user.toMap());
    } on PlatformException catch (e) {
      throw AdaptiveException(code: e.code, message: e.message ?? '');
    }
  }

  /// Logs the current user out and clears the HTTP request queue.
  ///
  /// Throws [AdaptiveException] on failure.
  static Future<void> logout() async {
    try {
      await _channel.invokeMethod<void>('logout');
    } on PlatformException catch (e) {
      throw AdaptiveException(code: e.code, message: e.message ?? '');
    }
  }
}
