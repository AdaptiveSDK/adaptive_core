## 1.0.19

* Bumped iOS `AdaptiveCore` CocoaPod dependency pin to `~> 1.0.19`.
* Bumped Android native dependency pin to `adaptive-core:1.0.19`.

## 1.0.12

* **`AdaptiveCore.login`** – now accepts a `phoneNumber` field on `AdaptiveUser`.
  The phone number is forwarded to the native SDK and automatically injected into
  every subsequent analytics and messaging request.
* **Android** – `InternalHttpClient` now logs a structured `→ REQUEST` block
  (method, full URL, body) before every call and a `← RESPONSE` block (method,
  URL, HTTP status, response body) on completion. Replaces previous partial
  log messages. Gated by debug mode.
* **Android** – removed `mavenLocal()` from `rootProject.allprojects` repositories;
  all dependencies now resolve exclusively from Maven Central.
* Bumped Android native dependency pin to `adaptive-core:1.0.11`.
* Bumped iOS `AdaptiveCore` CocoaPod dependency pin to `~> 1.0.12`.

## 1.0.8

* Moved iOS podspec to `ios/` directory (standard Flutter plugin layout).
* Lowered iOS minimum deployment target from 15.0 to 13.0.
* Pinned `AdaptiveCore` CocoaPod dependency to `~> 1.0.10`.
* Fixed `MethodChannel` declaration to use `const` constructor.
* Sorted `dev_dependencies` alphabetically in `pubspec.yaml`.

## 1.0.7

* Minor improvements to Android build configuration.

## 1.0.6

* Added iOS platform support (iOS 15.0+).
* Fixed README package name references to use correct pub.dev package names.

## 1.0.0

* Initial release.
* `AdaptiveCore.initialize` — initialize the SDK with your client API key.
* `AdaptiveCore.login` — attach an `AdaptiveUser` to the current session.
* `AdaptiveCore.logout` — clear the user session and flush the HTTP queue.
* `AdaptiveCore.post` / `AdaptiveCore.get` — resilient HTTP client with offline queue, exponential back-off, and up to 3 automatic retries.
