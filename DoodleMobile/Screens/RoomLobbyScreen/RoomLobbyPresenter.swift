import Foundation
import UIKit

protocol RoomLobbyViewControllerInput: UIViewController {
    func updateRoomLobbyModel(_ roomLobbyModel: RoomLobbyModel)
}

protocol RoomLobbyViewControllerOutput { }

class RoomLobbyPresenter: RoomLobbyViewControllerOutput {
    weak var view: RoomLobbyViewControllerInput?
}

extension RoomLobbyPresenter: LobbyStompHandlerDelegate {
    func lobbyStompHandler(_ lobbyStompHandler: LobbyStompHandler, updateWith message: RoomStompResponse) {
        view?.updateRoomLobbyModel(.init(with: message))
    }
    
}
