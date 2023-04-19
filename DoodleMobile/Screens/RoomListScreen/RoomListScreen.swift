import Foundation
import UIKit

class RoomListScreen {
    func assemble() -> UIViewController {
        let view = RoomListViewController()
        let presenter = RoomListPresenter()
        view.output = presenter
        presenter.view = view
        return view
    }
}
