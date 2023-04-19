import Foundation
import UIKit

extension MainMenuViewController {
    private enum Constants {
        enum Measure {
            static let buttonsSpacing: CGFloat = 16
            static let sideOffsets: CGFloat = 32
        }
        enum Color {
            static let background: UIColor = .white
        }
        enum Text {
            static let joinRoomButtonTitle = "Join Room"
            static let createRoomButtonTitle = "Create Room"
        }
    }
}

class MainMenuViewController: UIViewController {
    
    var output: MainMenuViewControllerOutput?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = Constants.Measure.buttonsSpacing
        return stackView
    }()
    
    private lazy var joinRoomButton: Button = {
        let button = Button()
        button.setDefaultAppearance()
        button.setTitle(Constants.Text.joinRoomButtonTitle, for: .normal)
        button.onPress = { [weak self] in
            self?.output?.joinRoomButtonPressed()
        }
        return button
    }()
    
    private lazy var createRoomButton: Button = {
        let button = Button()
        button.setDefaultAppearance()
        button.onPress = { [weak self] in
            self?.output?.createRoomButtonPressed()
        }
        button.setTitle(Constants.Text.createRoomButtonTitle, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.Color.background
        setupButtonActions()
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupViewHierarchy() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(joinRoomButton)
        stackView.addArrangedSubview(createRoomButton)
    }
    
    private func setupButtonActions() {
        joinRoomButton.onPress = { [weak self] in
            self?.output?.joinRoomButtonPressed()
        }
        createRoomButton.onPress = { [weak self] in
            self?.output?.createRoomButtonPressed()
        }
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Measure.sideOffsets),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Measure.sideOffsets)
        ])
    }
    
}

extension MainMenuViewController: MainMenuViewControllerInput { }
