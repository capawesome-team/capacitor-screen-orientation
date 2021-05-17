import Foundation

@objc public class ScreenOrientation: NSObject {
    static var supportedInterfaceOrientations = UIInterfaceOrientationMask.all
    
    @objc public static func getSupportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return ScreenOrientation.supportedInterfaceOrientations
    }
    
    @objc public func lock(_ orientationType: String) {
        DispatchQueue.main.async {
            let orientationValue = self.convertOrientationTypeToValue(orientationType)
            let orientationMask = self.convertOrientationTypeToMask(orientationType)
            UIDevice.current.setValue(orientationValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
            ScreenOrientation.supportedInterfaceOrientations = orientationMask
        }
    }
    
    @objc public func unlock() {
        DispatchQueue.main.async {
            UIDevice.current.setValue(0, forKey: "orientation")
            ScreenOrientation.supportedInterfaceOrientations = UIInterfaceOrientationMask.all
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
    
    @objc private func convertOrientationTypeToValue(_ orientationType: String) -> Int {
        switch orientationType {
        case "landscape":
            return UIInterfaceOrientation.landscapeRight.rawValue
        case "landscape-primary":
            return UIInterfaceOrientation.landscapeLeft.rawValue
        case "landscape-secondary":
            return UIInterfaceOrientation.landscapeRight.rawValue
        case "potrait":
            return UIInterfaceOrientation.portrait.rawValue
        case "potrait-primary":
            return UIInterfaceOrientation.portrait.rawValue
        case "potrait-secondary":
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
            return "potrait-primary"
        case UIInterfaceOrientation.portraitUpsideDown.rawValue:
            return "potrait-secondary"
        default:
            return "potrait-primary"
        }
    }
}
