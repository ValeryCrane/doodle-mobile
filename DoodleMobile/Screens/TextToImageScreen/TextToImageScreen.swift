import Foundation
import UIKit

class TextToImageScreen {
    func assemble(with viewModel: TextToImageViewModel) -> UIViewController {
        let view = TextToImageViewController(with: viewModel)
        let presenter = TextToImagePresenter()
        view.output = presenter
        presenter.view = view
        return view
    }
}
