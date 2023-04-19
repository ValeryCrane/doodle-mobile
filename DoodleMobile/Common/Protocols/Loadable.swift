import Foundation
import UIKit

protocol Loadable: UIViewController {
    func startLoading()
    func stopLoading()
}

extension UIViewController: Loadable {
    
    private enum AssociatedKeys {
        static var loader = "Loadable.AssociatedKeys.loader"
    }
    
    private var loader: Loader {
        if let loader = objc_getAssociatedObject(self, &AssociatedKeys.loader) as? Loader {
            return loader
        } else {
            let loader = Loader()
            objc_setAssociatedObject(self, &AssociatedKeys.loader, loader, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return loader
        }
    }
    
    func startLoading() {
        loader.start(on: self)
    }
    
    func stopLoading() {
        loader.stop()
    }
}
