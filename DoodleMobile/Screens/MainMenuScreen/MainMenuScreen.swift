import Foundation
import UIKit

class MainMenuScreen {
    func assemble() -> UIViewController {
        let view = MainMenuViewController()
        let presenter = MainMenuPresenter()
        view.output = presenter
        presenter.view = view
        return view
    }
}
