import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(ScreenOrientationPlugin)
public class ScreenOrientationPlugin: CAPPlugin {
    private let implementation = ScreenOrientation()

    @objc func lock(_ call: CAPPluginCall) {
        let orientationType = call.getString("type") ?? ""
        implementation.lock(orientationType)
        call.resolve()
    }
    
    @objc func unlock(_ call: CAPPluginCall) {
        implementation.unlock()
        call.resolve()
    }
    
    @objc func getCurrentOrientation(_ call: CAPPluginCall) {
        let orientationType = implementation.getCurrentOrientationType()
        call.resolve([
            "type": orientationType
        ])
    }
}
