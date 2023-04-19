import Foundation
import UIKit

class LaunchHandler {
    private static let launchCountKey = "LaunchHandler.launchCountKey"
    
    var isFirstLaunch: Bool {
        return UserDefaults.standard.integer(forKey: Self.launchCountKey) <= 1
    }
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appLaunched(_:)),
            name: UIApplication.didFinishLaunchingNotification,
            object: nil
        )
    }
    
    @objc
    private func appLaunched(_ sender: NSNotification) {
        let currentLaunchCount = UserDefaults.standard.integer(forKey: Self.launchCountKey)
        UserDefaults.standard.set(currentLaunchCount + 1, forKey: Self.launchCountKey)
    }
}
