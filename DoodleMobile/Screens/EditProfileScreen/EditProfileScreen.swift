import Foundation
import UIKit

class EditProfileScreen {
    func assemble(with viewModel: EditProfileViewModel? = nil) -> UIViewController {
        let view = EditProfileViewController(initialViewModel: viewModel)
        let presenter = EditProfilePresenter()
        view.output = presenter
        presenter.view = view
        return view
    }
}
