import Foundation

protocol RoomsStompHandlerDelegate: AnyObject {
    func update(with message: [RoomStompResponse])
}

class RoomsStompHandler: StompHandler {
    typealias MessageType = [RoomStompResponse]
    
    weak var delegate: RoomsStompHandlerDelegate?
    
    var subscriprionTopics: [StompSubscriptionTopic] = [.rooms]
    
    func handleMessage(_ message: [RoomStompResponse]) -> Bool {
        delegate?.update(with: message)
        return true
    }
}
