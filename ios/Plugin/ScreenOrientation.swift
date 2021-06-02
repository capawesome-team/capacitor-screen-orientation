import Foundation
import UIKit

@objc public class ScreenOrientation: NSObject {
    static var supportedInterfaceOrientations = UIInterfaceOrientationMask.all

    @objc public static func getSupportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return ScreenOrientation.supportedInterfaceOrientations
    }

    @objc public func lock(_ orientationType: String, completion: @escaping () -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            let orientationMask = strongSelf.convertOrientationTypeToMask(orientationType)
            UIDevice.current.setValue(orientationMask.rawValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
            ScreenOrientation.supportedInterfaceOrientations = orientationMask
            completion()
        }
    }

    @objc public func unlock(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            UIDevice.current.setValue(0, forKey: "orientation")
            ScreenOrientation.supportedInterfaceOrientations = UIInterfaceOrientationMask.all
            completion()
        }
    }

    @objc public func getCurrentOrientationType() -> String {
        let orientationValue = UIDevice.current.orientation.rawValue
        let orientationType = self.convertOrientationValueToType(orientationValue)
        return orientationType
    }

    @objc private func convertOrientationTypeToMask(_ orientationType: String) -> UIInterfaceOrientationMask {
        switch orientationType {
        case "landscape":
            return UIInterfaceOrientationMask.landscapeRight
        case "landscape-primary":
            return UIInterfaceOrientationMask.landscapeLeft
        case "landscape-secondary":
            return UIInterfaceOrientationMask.landscapeRight
        case "potrait":
            return UIInterfaceOrientationMask.portrait
        case "potrait-primary":
            return UIInterfaceOrientationMask.portrait
        case "potrait-secondary":
            return UIInterfaceOrientationMask.portraitUpsideDown
        default:
            return UIInterfaceOrientationMask.all
        }
    }

    @objc private func convertOrientationValueToType(_ orientationValue: Int) -> String {
        switch orientationValue {
        case UIInterfaceOrientation.landscapeLeft.rawValue:
            return "landscape-primary"
        case UIInterfaceOrientation.landscapeRight.rawValue:
            return "landscape-secondary"
        case UIInterfaceOrientation.portrait.rawValue:
            return "potrait-primary"
        case UIInterfaceOrientation.portraitUpsideDown.rawValue:
            return "potrait-secondary"
        default:
            return "potrait-primary"
        }
    }
}
