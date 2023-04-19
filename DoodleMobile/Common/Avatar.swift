import Foundation
import UIKit

enum Avatar: String, CaseIterable {
    case redGhost = "red_ghost"
    case cyanGhost = "cyan_ghost"
    case greenGhost = "green_ghost"
    case magentaGhost = "magenta_ghost"
    case orangeGhost = "orange_ghost"
    case burgundyGhost = "burgundy_ghost"
    case yellowGhost = "yellow_ghost"
    case blueGhost = "blue_ghost"
    
    var image: UIImage {
        switch self {
        case .redGhost:
            return .res.redGhost
        case .cyanGhost:
            return .res.cyanGhost
        case .greenGhost:
            return .res.greenGhost
        case .magentaGhost:
            return .res.magentaGhost
        case .orangeGhost:
            return .res.orangeGhost
        case .burgundyGhost:
            return .res.burgundyGhost
        case .yellowGhost:
            return .res.yellowGhost
        case .blueGhost:
            return .res.blueGhost
        }
    }
}
