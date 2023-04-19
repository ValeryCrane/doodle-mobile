import Foundation
import UIKit

class TestScreen: UIViewController {
    
    private let backgroundView: UIImageView = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backgroundView.frame = view.bounds
        updateBackgroundImage()
    }
    
    private func updateBackgroundImage() {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        for x in 0 ..< Int(view.bounds.width) {
            for y in 0 ..< Int(view.bounds.height) {
                let alpha = CGFloat(Float.random(in: 0.0 ... 1.0))
                UIColor.black.withAlphaComponent(alpha).set()
                UIRectFill(.init(x: CGFloat(x), y: CGFloat(y), width: 1, height: 1))
                print(alpha)
            }
        }
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        backgroundView.image = image
    }
}
