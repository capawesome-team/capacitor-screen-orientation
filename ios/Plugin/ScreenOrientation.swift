import Foundation
import UIKit

@objc public class ScreenOrientation: NSObject {
    static var supportedInterfaceOrientations = UIInterfaceOrientationMask.all
    private let plugin: ScreenOrientationPlugin
    private var currentOrientationType: String?
    private var lastOrientationType: String?

    init(plugin: ScreenOrientationPlugin) {
        self.plugin = plugin
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleOrientationChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    @objc public static func getSupportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return ScreenOrientation.supportedInterfaceOrientations
    }

    @objc public func lock(_ orientationType: String, completion: @escaping () -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            let currentOrientationValue = UIDevice.current.orientation.rawValue
            let nextOrientationMask = strongSelf.convertOrientationTypeToMask(orientationType)
            let nextOrientationValue = strongSelf.convertOrientationTypeToValue(orientationType)
            UIDevice.current.setValue(nextOrientationValue, forKey: "orientation")
            ScreenOrientation.supportedInterfaceOrientations = nextOrientationMask
            UINavigationController.attemptRotationToDeviceOrientation()
            UIDevice.current.setValue(currentOrientationValue, forKey: "orientation")
            strongSelf.notifyOrientationChangeListeners(orientationType)
            completion()
        }
    }

    @objc public func unlock(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            ScreenOrientation.supportedInterfaceOrientations = UIInterfaceOrientationMask.all
            UINavigationController.attemptRotationToDeviceOrientation()
            guard let orientationType = self.lastOrientationType else {
                return
            }
            self.notifyOrientationChangeListeners(orientationType)
            completion()
        }
    }

    @objc public func getCachedCurrentOrientationType(completion: @escaping (String) -> Void) {
        guard let cachedOrientationType = self.currentOrientationType else {
            self.getUncachedCurrentOrientationType(completion: completion)
            return
        }
        completion(cachedOrientationType)
    }

    @objc private func getUncachedCurrentOrientationType(completion: @escaping (String) -> Void) {
        DispatchQueue.main.async {
            let orientationValue = UIDevice.current.orientation.rawValue
            let orientationType = self.convertOrientationValueToType(orientationValue)
            completion(orientationType)
        }
    }

    @objc private func isCurrentOrientationValid() -> Bool {
        return UIDevice.current.orientation.isValidInterfaceOrientation
    }

    @objc private func handleOrientationChange() {
        let isValid = self.isCurrentOrientationValid()
        guard isValid else {
            return
        }
        self.getUncachedCurrentOrientationType(completion: { orientationType in
            self.lastOrientationType = orientationType
            guard ScreenOrientation.supportedInterfaceOrientations == UIInterfaceOrientationMask.all else {
                return
            }
            self.notifyOrientationChangeListeners(orientationType)
        })
    }

    @objc private func notifyOrientationChangeListeners(_ orientationType: String) {
        self.currentOrientationType = orientationType
        self.plugin.notifyOrientationChangeListeners(orientationType)
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
