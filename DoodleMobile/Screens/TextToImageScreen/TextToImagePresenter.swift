import Foundation
import UIKit

protocol TextToImageViewControllerInput: UIViewController { }

protocol TextToImageViewControllerOutput {
    func saveImage(_ image: UIImage)
}

class TextToImagePresenter {
    weak var view: TextToImageViewControllerInput?
}

extension TextToImagePresenter: TextToImageViewControllerOutput {
    func saveImage(_ image: UIImage) {
        view?.startLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.view?.stopLoading()
        }
    }
    
    
}

