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
            let orientationValue = strongSelf.convertOrientationTypeToValue(orientationType)
            UIDevice.current.setValue(orientationValue, forKey: "orientation")
            ScreenOrientation.supportedInterfaceOrientations = orientationMask
            UINavigationController.attemptRotationToDeviceOrientation()
            completion()
        }
    }

    @objc public func unlock(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            let orientationValue = UIInterfaceOrientation.unknown.rawValue
            UIDevice.current.setValue(orientationValue, forKey: "orientation")
            ScreenOrientation.supportedInterfaceOrientations = UIInterfaceOrientationMask.all
            completion()
        }
    }

    @objc public func getCurrentOrientationType(completion: @escaping (String) -> Void) {
        DispatchQueue.main.async {
            let orientationValue = UIDevice.current.orientation.rawValue
            let orientationType = self.convertOrientationValueToType(orientationValue)
            completion(orientationType)
        }
    }

    @objc public func isCurrentOrientationValid() -> Bool {
        let isValid = UIDevice.current.orientation.isValidInterfaceOrientation
        return isValid
    }

    @objc private func convertOrientationTypeToMask(_ orientationType: String) -> UIInterfaceOrientationMask {
        switch orientationType {
        case "landscape":
            return UIInterfaceOrientationMask.landscapeRight
        case "landscape-primary":
            return UIInterfaceOrientationMask.landscapeLeft
        case "landscape-secondary":
            return UIInterfaceOrientationMask.landscapeRight
        case "portrait":
            return UIInterfaceOrientationMask.portrait
        case "portrait-primary":
            return UIInterfaceOrientationMask.portrait
        case "portrait-secondary":
            return UIInterfaceOrientationMask.portraitUpsideDown
        default:
            return UIInterfaceOrientationMask.all
        }
    }

    @objc private func convertOrientationTypeToValue(_ orientationType: String) -> Int {
        switch orientationType {
        case "landscape":
            return UIInterfaceOrientation.landscapeRight.rawValue
        case "landscape-primary":
            return UIInterfaceOrientation.landscapeLeft.rawValue
        case "landscape-secondary":
            return UIInterfaceOrientation.landscapeRight.rawValue
        case "portrait":
            return UIInterfaceOrientation.portrait.rawValue
        case "portrait-primary":
            return UIInterfaceOrientation.portrait.rawValue
        case "portrait-secondary":
            return UIInterfaceOrientation.portraitUpsideDown.rawValue
        default:
            return UIInterfaceOrientation.unknown.rawValue
        }
    }

    @objc private func convertOrientationValueToType(_ orientationValue: Int) -> String {
        switch orientationValue {
        case UIInterfaceOrientation.landscapeLeft.rawValue:
            return "landscape-primary"
        case UIInterfaceOrientation.landscapeRight.rawValue:
            return "landscape-secondary"
        case UIInterfaceOrientation.portrait.rawValue:
            return "portrait-primary"
        case UIInterfaceOrientation.portraitUpsideDown.rawValue:
            return "portrait-secondary"
        default:
            let isPortrait = UIApplication.shared.statusBarOrientation.isPortrait
            return isPortrait ? "portrait-primary" : "landscape-primary"
        }
    }
}
