import Foundation
import UIKit

protocol MainMenuViewControllerInput: UIViewController { }

protocol MainMenuViewControllerOutput {
    func joinRoomButtonPressed()
    func createRoomButtonPressed()
    func profileButtonPressed()
}

class MainMenuPresenter: MainMenuViewControllerOutput {
    
    weak var view: MainMenuViewControllerInput?
    
    func joinRoomButtonPressed() {
        let roomListScreen = RoomListScreen().assemble()
        view?.navigationController?.pushViewController(roomListScreen, animated: true)
    }
    
    func createRoomButtonPressed() {
        let createRoomScreen = CreateRoomScreen().assemble()
        view?.navigationController?.pushViewController(createRoomScreen, animated: true)
    }
    
    func profileButtonPressed() {
        // TODO: Move to profile redactor
    }
}
