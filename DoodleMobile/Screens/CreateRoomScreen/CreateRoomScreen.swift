import Foundation
import UIKit

class CreateRoomScreen {
    func assemble() -> UIViewController {
        let view = CreateRoomViewController()
        let presenter = CreateRoomPresenter()
        view.output = presenter
        presenter.view = view
        return view
    }
}
