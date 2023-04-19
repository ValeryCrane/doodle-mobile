import Foundation
import UIKit

protocol CreateRoomViewControllerInput: UIViewController { }

protocol CreateRoomViewControllerOutput {
    func createRoom(_ room: RoomModel)
}

class CreateRoomPresenter: CreateRoomViewControllerOutput {
    
    weak var view: CreateRoomViewControllerInput?
    
    private let createRoomRequest = CreateRoomRequest()
    
    func createRoom(_ room: RoomModel) {
        view?.startLoading()
        createRoomRequest.setup(with: .init(roomModel: room))
        createRoomRequest.send(success: { [weak self] response in
            DispatchQueue.main.async {
                let handler = LobbyStompHandler(roomId: response.id)
                handler.delegate = self
                StompManager.shared.addHandler(handler)
            }
        }, fail: { [weak self] error in
            print(error?.localizedDescription ?? "error")
            DispatchQueue.main.async {
                self?.view?.stopLoading()
            }
        })
    }
    
    
}

extension CreateRoomPresenter: LobbyStompHandlerDelegate {
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
