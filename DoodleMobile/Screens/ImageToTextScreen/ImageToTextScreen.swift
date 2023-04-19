import Foundation
import UIKit

class ImageToTextScreen {
    func assemble(with viewModel: ImageToTextViewModel) -> UIViewController {
        let view = ImageToTextViewController(with: viewModel)
        let presenter = TextToImagePresenter()
        view.output = presenter
        return view
    }
}
