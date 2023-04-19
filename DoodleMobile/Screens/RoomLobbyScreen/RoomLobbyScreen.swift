import Foundation
import UIKit

class RoomLobbyScreen {
    
    func assemble(roomLobbyModel: RoomLobbyModel) -> (UIViewController, LobbyStompHandlerDelegate) {
        let view = RoomLobbyScreenViewController(roomLobbyModel: roomLobbyModel)
        let presenter = RoomLobbyPresenter()
        view.output = presenter
        return (view, presenter)
    }
}
