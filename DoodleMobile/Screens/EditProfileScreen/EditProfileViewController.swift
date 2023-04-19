import Foundation
import UIKit

/// Экран для редактирования профиля пользователя.
class EditProfileViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        enum Color {
            static let background: UIColor = .white
        }
        enum Text {
            static let title = "Edit profile"
            static let usernameLabel = "Username"
            static let usernamePlaceholder = "random_user2002"
            static let saveButton = "Save"
        }
        enum Measure {
            static let stackViewSpacing: CGFloat = 16
            static let sideOffsets: CGFloat = 32
            static let avatarSize: CGFloat = 64
            static let avatarCornerRadius: CGFloat = 8
        }
    }
    
    // MARK: Properties
    
    var output: EditProfileViewControllerOutput?
    
    private let initialViewModel: EditProfileViewModel?
    private let avatars: [Avatar] = Avatar.allCases
    private var selectedAvatar: Avatar?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.Measure.stackViewSpacing
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.usernameLabel
        label.textAlignment = .center
        return label
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.Text.usernamePlaceholder
        textField.textAlignment = .center
        textField.addTarget(self, action: #selector(usernameFieldChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var saveButton: Button = {
        let button = Button()
        button.setDefaultAppearance()
        button.setTitle(Constants.Text.saveButton, for: .normal)
        button.onPress = { [weak self] in
            if let username = self?.usernameTextField.text, let avatar = self?.selectedAvatar {
                self?.output?.saveProfileModel(.init(
                    avatar: avatar,
                    username: username
                ))
            }
        }
        return button
    }()
    
    private lazy var avatarCollectionView: CollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = .init(
            width: Constants.Measure.avatarSize,
            height: Constants.Measure.avatarSize
        )
        
        let collectionView = CollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.register(AvatarCell.self, forCellWithReuseIdentifier: AvatarCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: Init
    
    init(initialViewModel: EditProfileViewModel? = nil) {
        self.initialViewModel = initialViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ViewController's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.Color.background
        title = Constants.Text.title
        setupInitialState()
        setupViewHierarchy()
        setupConstraints()
        updateSaveButtonIsEnabled()
    }
    
    // MARK: Private functions
    
    private func setupViewHierarchy() {
        view.addSubview(stackView)
        [avatarCollectionView, usernameLabel, usernameTextField, saveButton].forEach({
            stackView.addArrangedSubview($0)
        })
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Measure.sideOffsets),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Measure.sideOffsets)
        ])
    }
    
    private func setupInitialState() {
        guard
            let initialViewModel = initialViewModel,
            let avatarIndex = avatars.firstIndex(of: initialViewModel.avatar)
        else { return }
        
        avatarCollectionView.selectItem(
            at: .init(row: avatarIndex, section: 0),
            animated: false,
            scrollPosition: .top
        )
        usernameTextField.text = initialViewModel.username
    }
    
    private func updateSaveButtonIsEnabled() {
        saveButton.isEnabled = (
            usernameTextField.text != nil &&
            usernameTextField.text != "" &&
            selectedAvatar != nil
        )
    }
    
    @objc
    private func usernameFieldChanged(_ sender: UITextField) {
        updateSaveButtonIsEnabled()
    }
}

// MARK: UICollectionViewDataSource

extension EditProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        avatars.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AvatarCell.reuseIdentifier,
            for: indexPath
        ) as? AvatarCell
        
        cell?.setup(with: avatars[indexPath.row])
        cell?.layer.cornerRadius = Constants.Measure.avatarCornerRadius
        return cell ?? UICollectionViewCell()
    }
}

// MARK: UICollectionViewDelegate

extension EditProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedAvatar = avatars[indexPath.row]
        updateSaveButtonIsEnabled()
    }
}

// MARK: EditProfileViewControllerInput

extension EditProfileViewController: EditProfileViewControllerInput { }
