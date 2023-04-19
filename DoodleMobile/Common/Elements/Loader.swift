import Foundation
import UIKit

class Loader {
    private var window: UIWindow?
    private weak var underlyingWindow: UIWindow?
    
    func start(on viewController: UIViewController) {
        guard
            let underlyingWindow = viewController.view.window,
            let windowScene = underlyingWindow.windowScene
        else { return }
        
        self.underlyingWindow = underlyingWindow
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = LoaderViewController()
        window?.windowLevel = .init(rawValue: CGFLOAT_MAX - 1000)
        window?.makeKeyAndVisible()
    }
    
    func stop() {
        window?.resignKey()
        window = nil
        
        underlyingWindow?.makeKeyAndVisible()
        underlyingWindow = nil
    }
}

extension Loader {
    private class LoaderViewController: UIViewController {
        
        private enum Constants {
            static let size: CGFloat = 80
            static let cornerRadius: CGFloat = 16
            static let shadowColor: CGColor = UIColor.black.cgColor
            static let shadowRadius: CGFloat = 8
            static let shadowOpacity: Float = 0.2
        }
        
        private let backgroundView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = Constants.cornerRadius
            view.layer.shadowColor = Constants.shadowColor
            view.layer.shadowRadius = Constants.shadowRadius
            view.layer.shadowOpacity = Constants.shadowOpacity
            return view
        }()
        
        private let activityIndicator: UIActivityIndicatorView = {
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.hidesWhenStopped = true
            return activityIndicator
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .clear
            setupViewHierarchy()
            setupConstraints()
            activityIndicator.startAnimating()
        }
        
        private func setupViewHierarchy() {
            view.addSubview(backgroundView)
            backgroundView.addSubview(activityIndicator)
        }
        
        private func setupConstraints() {
            [backgroundView, activityIndicator].forEach({
                $0.translatesAutoresizingMaskIntoConstraints = false
            })
            NSLayoutConstraint.activate([
                backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                backgroundView.heightAnchor.constraint(equalToConstant: Constants.size),
                backgroundView.widthAnchor.constraint(equalToConstant: Constants.size)
            ])
        }
    }
}
