import Foundation
import UIKit

protocol LobbyStompHandlerDelegate: AnyObject {
    func lobbyStompHandler(_ lobbyStompHandler: LobbyStompHandler, updateWith message: RoomStompResponse)
}

class LobbyStompHandler: StompHandler {
    typealias MessageType = RoomStompResponse
    
    weak var delegate: LobbyStompHandlerDelegate?
    
    var subscriprionTopics: [StompSubscriptionTopic]
    
    init(roomId: Int) {
        subscriprionTopics = [.room(id: roomId)]
    }
    
    func handleMessage(_ message: RoomStompResponse) -> Bool {
        delegate?.lobbyStompHandler(self, updateWith: message)
        return true
    }
}
