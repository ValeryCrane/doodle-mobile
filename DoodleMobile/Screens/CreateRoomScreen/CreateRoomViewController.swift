import Foundation
import UIKit

class CreateRoomViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        enum Color {
            static let background: UIColor = .white
        }
        enum Measure {
            static let stackViewSpacing: CGFloat = 16
            static let sideOffsets: CGFloat = 32
        }
        enum Text {
            static let nameLabel = "Room name"
            static let namePlaceholder = "Cool_room4"
            static let numberOfPlayersLabel = "Number of players:"
            static let createButton = "Create"
        }
    }
    
    // MARK: Properties
    
    var output: CreateRoomViewControllerOutput?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.Measure.stackViewSpacing
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.nameLabel
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.Text.namePlaceholder
        textField.textAlignment = .center
        textField.addTarget(self, action: #selector(nameFieldChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private let numberOfPlayersTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.numberOfPlayersLabel
        label.textAlignment = .center
        return label
    }()
    
    private let numberOfPlayersLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var numberOfPlayersSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 5
        slider.addTarget(self, action: #selector(numberOfPlayerSliderChanged(_:)), for: .valueChanged)
        return slider
    }()
    
    private lazy var createButton: Button = {
        let button = Button()
        button.setDefaultAppearance()
        button.setTitle(Constants.Text.createButton, for: .normal)
        button.onPress = { [weak self] in
            if
                let roomName = self?.nameTextField.text,
                let numberOfPlayers = self?.numberOfPlayersSlider.value.rounded()
            {
                self?.output?.createRoom(.init(
                    id: 0,
                    name: roomName,
                    currentNumberOfPlayers: 1,
                    maxNumberOfPlayers: Int(numberOfPlayers)
                ))
            }
        }
        button.isEnabled = false
        return button
    }()
    
    // MARK: ViewController's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.Color.background
        setupViewHierarchy()
        setupConstraints()
    }
    
    // MARK: Private functions
    
    private func setupViewHierarchy() {
        view.addSubview(stackView)
        [
            nameLabel,
            nameTextField,
            numberOfPlayersTitleLabel,
            numberOfPlayersLabel,
            numberOfPlayersSlider,
            createButton
        ].forEach({
            stackView.addArrangedSubview($0)
        })
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Measure.sideOffsets),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Measure.sideOffsets)
        ])
    }
    
    @objc
    private func nameFieldChanged(_ sender: UITextField) {
        createButton.isEnabled = sender.text != nil && sender.text != ""
    }
    
    @objc
    private func numberOfPlayerSliderChanged(_ sender: UISlider) {
        numberOfPlayersLabel.text = "\(Int(sender.value.rounded()))"
    }
}

// MARK: CreateRoomViewControllerInput

extension CreateRoomViewController: CreateRoomViewControllerInput { }
