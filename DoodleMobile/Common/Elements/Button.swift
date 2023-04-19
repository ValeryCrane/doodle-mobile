import Foundation
import UIKit


// TODO: Убрать дефолтный стиль, сделать дизайн систему.
class Button: UIButton {
    
    private enum Constants {
        static let height: CGFloat = 64
        static let cornerRadius: CGFloat = 8
        static let backgroundColor: UIColor = .systemTeal
        static let disabledbackgroundColor: UIColor = .systemTeal.withAlphaComponent(0.5)
    }
    
    var onPress: (() -> Void)?
    
    override var isEnabled: Bool {
        didSet {
            if isDefaultAppearance {
                if isEnabled {
                    backgroundColor = Constants.backgroundColor
                } else {
                    backgroundColor = Constants.disabledbackgroundColor
                }
            }
        }
    }
    
    private var isDefaultAppearance = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    func setDefaultAppearance() {
        isDefaultAppearance = true
        layer.cornerRadius = Constants.cornerRadius
        backgroundColor = isEnabled ? Constants.backgroundColor : Constants.disabledbackgroundColor
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: Constants.height).isActive = true
    }
    
    private func setup() {
        addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
    
    @objc
    private func buttonPressed(_ sender: UIButton) {
        onPress?()
    }
    
}
