import Foundation
import UIKit

enum Global {
    static let host = "localhost:80"
    static let websocketPath = "/connect"
    static let accessToken = UIDevice.current.identifierForVendor!.uuidString
}
