import Foundation
import UIKit
import PencilKit

class TextToImageViewController: UIViewController, TextToImageViewControllerInput {
    
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
        saveButton.onPress = { [weak self] in
            if let self = self {
                self.saveButton.isEnabled = false
                self.output?.saveImage(self.canvasView.drawing.image(from: self.canvasView.frame, scale: 1.0))
            }
        }
        return saveButton
    }()
    
    private let timerLayer : CALayer = {
        let timerLayer = CALayer()
        timerLayer.backgroundColor = UIColor.systemGray5.cgColor
        return timerLayer
    }()
    
    private let toolPicker = PKToolPicker()
    
    private lazy var canvasView: PKCanvasView = {
        let canvasView = PKCanvasView()
        canvasView.drawingPolicy = .anyInput
        canvasView.delegate = self
        return canvasView
    }()
    
    private let viewModel: TextToImageViewModel
    private var displayLink: CADisplayLink?
    
    init(with viewModel: TextToImageViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        displayLink = CADisplayLink(target: self, selector: #selector(updateTimer))
        displayLink?.add(to: .current, forMode: .common)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        title = "Нарисуйте:"
        navigationController?.view.backgroundColor = .white
        view.addSubview(canvasView)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
        
        setupViewHierarchy()
        setupConstraints()
    }
    
    private func setupViewHierarchy() {
        view.addSubview(titleView)
        view.addSubview(saveButton)
        titleView.layer.addSublayer(timerLayer)
        titleView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        canvasView.translatesAutoresizingMaskIntoConstraints = false
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
            saveButton.widthAnchor.constraint(equalToConstant: Constants.saveButtonSize),
            
            canvasView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            canvasView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            canvasView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            canvasView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc
    private func updateTimer() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        timerLayer.frame = .init(origin: .zero, size: .init(
            width: titleView.bounds.width * CGFloat(Date().timeIntervalSince1970 - CGFloat(viewModel.startTime)) / CGFloat(viewModel.duration),
            height: titleView.bounds.height))
        CATransaction.commit()
    }
}

extension TextToImageViewController: PKCanvasViewDelegate {
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        saveButton.isEnabled = true
    }
}
