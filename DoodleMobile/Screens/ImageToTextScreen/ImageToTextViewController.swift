import Foundation
import UIKit
import PencilKit

class ImageToTextViewController: UIViewController, ImageToTextViewControllerInput {
    
    private enum Constants {
        static let titleViewHeight: CGFloat = 80
        static let sideOffsets: CGFloat = 32
        static let saveButtonSize: CGFloat = 64
    }
    
    var output: TextToImageViewControllerOutput?
    
    private lazy var titleView: UIView = {
        let titleView = UIView()
        titleView.backgroundColor = .white
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.layer.shadowColor = UIColor.black.cgColor
        titleView.layer.shadowRadius = 8
        titleView.layer.shadowOpacity = 0.15
        return titleView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.text = "Невероятный закат"
        return titleLabel
    }()
    
    private lazy var saveButton: Button = {
        let saveButton = Button()
        saveButton.setDefaultAppearance()
        saveButton.isEnabled = false
        saveButton.tintColor = .white
        saveButton.setImage(.res.save, for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        return saveButton
    }()
    
    private let textField = UITextField()
    private let viewModel: ImageToTextViewModel
    
    init(with viewModel: ImageToTextViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        title = "Нарисуйте:"
        navigationController?.view.backgroundColor = .white
        
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupViewHierarchy() {
        view.addSubview(titleView)
        view.addSubview(saveButton)
        titleView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: Constants.titleViewHeight),
            
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: Constants.sideOffsets),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -Constants.sideOffsets),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            
            saveButton.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constants.sideOffsets),
            saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.sideOffsets),
            saveButton.heightAnchor.constraint(equalToConstant: Constants.saveButtonSize),
            saveButton.widthAnchor.constraint(equalToConstant: Constants.saveButtonSize)
        ])
    }
}
