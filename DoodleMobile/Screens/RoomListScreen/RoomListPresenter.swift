import Foundation
import UIKit

protocol RoomListViewControllerInput: UIViewController {
    func updateRooms(_ rooms: [RoomModel])
}

protocol RoomListViewControllerOutput {
    func startUpdating()
    func selectedRoom(_ room: RoomModel)
}

class RoomListPresenter: RoomListViewControllerOutput {
    
    weak var view: RoomListViewControllerInput?
    
    private let roomStompHandler = RoomsStompHandler()
    
    func startUpdating() {
        roomStompHandler.delegate = self
        StompManager.shared.addHandler(roomStompHandler)
        // TODO: Начать обновлять список комнат.
    }
    
    func selectedRoom(_ room: RoomModel) {
        view?.startLoading()
        let handler = LobbyStompHandler(roomId: room.id)
        handler.delegate = self
        StompManager.shared.addHandler(handler)
    }
}

extension RoomListPresenter: RoomsStompHandlerDelegate {
    func update(with message: [RoomStompResponse]) {
        view?.updateRooms(message.map({ RoomModel(
            id: $0.id,
            name: $0.name,
            currentNumberOfPlayers: $0.players.count,
            maxNumberOfPlayers: $0.capacity
        )}))
    }
}

extension RoomListPresenter: LobbyStompHandlerDelegate {
    func lobbyStompHandler(_ lobbyStompHandler: LobbyStompHandler, updateWith message: RoomStompResponse) {
        let (viewController, handlerDelegate) = RoomLobbyScreen().assemble(roomLobbyModel: .init(with: message))
        lobbyStompHandler.delegate = handlerDelegate
        view?.stopLoading()
        view?.navigationController?.pushViewController(
            viewController,
            animated: true
        )
    }
}
