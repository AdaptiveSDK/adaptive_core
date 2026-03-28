# adaptive_core_flutter

[![pub version](https://img.shields.io/pub/v/adaptive_core_flutter.svg)](https://pub.dev/packages/adaptive_core_flutter)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-android-green.svg)](https://pub.dev/packages/adaptive_core_flutter)

Flutter plugin for the **Adaptive SDK Core** module — the foundation layer required by all other Adaptive plugins. It provides:

- 🔑 **SDK Initialization** with your client API key
- 👤 **User session management** (login / logout)
- 🌐 **Resilient HTTP client** with an offline-first persistent request queue (encrypted storage, exponential back-off, up to 3 automatic retries)

> **Android only.** iOS support is not planned at this time.

---

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Setup](#setup)
- [Usage](#usage)
  - [Initialize](#1-initialize)
  - [Login](#2-login)
  - [Logout](#3-logout)
  - [Raw HTTP (advanced)](#4-raw-http-advanced)
- [Error Handling](#error-handling)
- [API Reference](#api-reference)
- [Contributing](#contributing)
- [License](#license)

---

## Requirements

| Requirement | Minimum Version |
|-------------|----------------|
| Flutter | 3.10.0 |
| Dart | 3.0.0 |
| Android `minSdk` | 24 (Android 7.0) |
| Android `compileSdk` | 34 |

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  adaptive_core_flutter: ^1.0.0
```

Then run:

```bash
flutter pub get
```

### Android permissions

The underlying SDK requires internet access. Add to your `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

---

## Setup

No additional Android Gradle configuration is needed. The plugin pulls the native `adaptive-core` AAR from **Maven Central** automatically via Gradle.

Ensure your `android/build.gradle` (project-level) includes `mavenCentral()`:

```groovy
allprojects {
    repositories {
        google()
        mavenCentral()   // ← required
    }
}
```

---

## Usage

### 1. Initialize

Call **once** at app startup — typically in `main()` before `runApp()`:

```dart
import 'package:adaptive_core_flutter/adaptive_core_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AdaptiveCore.initialize(
    clientId: 'YOUR_API_KEY',   // Provided by Adaptive
    debug: true,                 // Set to false in production
  );

  runApp(const MyApp());
}
```

### 2. Login

Call after the user authenticates in your app:

```dart
await AdaptiveCore.login(
  const AdaptiveUser(
    userId: '3244',               // Moodle / LMS user ID
    userName: 'Jane Doe',
    userEmail: 'jane@example.com',
  ),
);
```

### 3. Logout

Call when the user signs out:

```dart
await AdaptiveCore.logout();
```

This clears the current user session and flushes the pending HTTP request queue.

### 4. Raw HTTP (advanced)

You can use the built-in resilient HTTP client directly if needed:

```dart
// POST
await AdaptiveCore.post(
  path: 'moodle/custom-endpoint',
  body: '{"key": "value"}',
);

// GET
await AdaptiveCore.get(path: 'moodle/status');
```

Requests are queued automatically when the device is offline and retried once connectivity is restored.

---

## Error Handling

All methods throw `AdaptiveException` on failure:

```dart
try {
  await AdaptiveCore.initialize(clientId: 'YOUR_API_KEY');
} on AdaptiveException catch (e) {
  print('Error [${e.code}]: ${e.message}');
}
```

### Error codes

| Code | Cause |
|------|-------|
| `INITIALIZATION_ERROR` | SDK failed to initialize (e.g., invalid context) |
| `LOGIN_ERROR` | Login call failed or SDK not initialized |
| `LOGOUT_ERROR` | Logout call failed or SDK not initialized |
| `POST_ERROR` | HTTP POST failed after queue exhaustion |
| `GET_ERROR` | HTTP GET failed after queue exhaustion |
| `INVALID_ARGUMENT` | A required argument was missing or null |

---

## API Reference

### `AdaptiveCore`

| Method | Description |
|--------|-------------|
| `initialize({required String clientId, bool debug = false})` | Initializes the SDK. Must be called first. |
| `login(AdaptiveUser user)` | Attaches a user to the session. |
| `logout()` | Clears the session and HTTP queue. |
| `post({required String path, required String body})` | Sends a resilient POST request. |
| `get({required String path})` | Sends a resilient GET request. |

### `AdaptiveUser`

```dart
const AdaptiveUser({
  required String userId,    // LMS user ID
  required String userName,  // Display name
  required String userEmail, // Email address
});
```

### `AdaptiveException`

```dart
class AdaptiveException implements Exception {
  final String code;    // Machine-readable error code
  final String message; // Human-readable description
}
```

---

## Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'feat: add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

---

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
