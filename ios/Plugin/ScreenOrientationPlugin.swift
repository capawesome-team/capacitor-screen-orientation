import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(ScreenOrientationPlugin)
public class ScreenOrientationPlugin: CAPPlugin {
    public let screenOrientationChangeEvent = "screenOrientationChange"
    private var implementation: ScreenOrientation?

    override public func load() {
        self.implementation = ScreenOrientation(plugin: self)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func lock(_ call: CAPPluginCall) {
        let orientationType = call.getString("type") ?? ""
        implementation?.lock(orientationType, completion: {
            call.resolve()
        })
    }

    @objc func unlock(_ call: CAPPluginCall) {
        implementation?.unlock(completion: {
            call.resolve()
        })
    }

    @objc func getCurrentOrientation(_ call: CAPPluginCall) {
        implementation?.getCurrentOrientationType(completion: { orientationType in
            call.resolve([
                "type": orientationType
            ])
        })
    }

    @objc func notifyOrientationChangeListeners(_ orientationType: String) {
        self.notifyListeners(self.screenOrientationChangeEvent, data: [
            "type": orientationType
        ])
    }
}
