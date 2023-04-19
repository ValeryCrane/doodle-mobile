import Foundation
import UIKit

protocol ImageToTextViewControllerInput: UIViewController { }

protocol ImageToTextViewControllerOutput {
    func saveText(_ text: String)
}

class ImageToTextPresenter {
    weak var view: ImageToTextViewControllerInput?
}

