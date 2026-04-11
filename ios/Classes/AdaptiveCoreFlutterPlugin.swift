import Flutter
import UIKit
import AdaptiveCore

public class AdaptiveCoreFlutterPlugin: NSObject, FlutterPlugin {

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "adaptive_core",
            binaryMessenger: registrar.messenger()
        )
        let instance = AdaptiveCoreFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as? [String: Any] ?? [:]
        switch call.method {

        case "initialize":
            guard let clientId = args["clientId"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "clientId is required", details: nil))
                return
            }
            let debug = args["debug"] as? Bool ?? false
            AdaptiveCore.shared.initialize(clientId: clientId, debug: debug)
            result(nil)

        case "login":
            guard let userId    = args["userId"]    as? String,
                  let userName  = args["userName"]  as? String,
                  let userEmail = args["userEmail"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "userId, userName and userEmail are required", details: nil))
                return
            }
            let phoneNumber = args["phoneNumber"] as? String ?? ""
            AdaptiveCore.shared.login(userId: userId, userName: userName, userEmail: userEmail, phoneNumber: phoneNumber)
            result(nil)

        case "logout":
            AdaptiveCore.shared.logout()
            result(nil)

        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
