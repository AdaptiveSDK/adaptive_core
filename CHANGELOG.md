## 1.0.6

* Added iOS platform support (iOS 15.0+).
* Fixed README package name references to use correct pub.dev package names.

## 1.0.0

* Initial release.
* `AdaptiveCore.initialize` — initialize the SDK with your client API key.
* `AdaptiveCore.login` — attach an `AdaptiveUser` to the current session.
* `AdaptiveCore.logout` — clear the user session and flush the HTTP queue.
* `AdaptiveCore.post` / `AdaptiveCore.get` — resilient HTTP client with offline queue, exponential back-off, and up to 3 automatic retries.
