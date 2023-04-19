import Foundation

enum StompSubscriptionTopic: RawRepresentable, Equatable {
    case room(id: Int)
    case rooms
    
    var rawValue: String {
        switch self {
        case let .room(id):
            return "/topic/room/\(id)"
        case .rooms:
            return "/topic/room"
        }
    }
    
    init?(rawValue: String) {
        let rawValue = rawValue.starts(with: "/user") ? String(rawValue.dropFirst("/user".count)) : rawValue
        if rawValue.starts(with: "/topic/room/") {
            self = .room(id: Int(String(rawValue.dropFirst("/topic/room/".count))) ?? 0)
            return
        } else if rawValue == "/topic/room" {
            self = .rooms
            return
        }
        return nil
    }
}
