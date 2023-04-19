import Foundation
import UIKit

class AvatarCell: UICollectionViewCell {
    static let reuseIdentifier = "AvatarCell"
    
    private enum Constants {
        static let placeholderColor: UIColor = .red
        static let cornerRadius: CGFloat = 8
        static let borderColor: UIColor = .black
        static let borderWidth: CGFloat = 4
    }
    
    private let imageView = UIImageView()
    
    override var isSelected: Bool {
        didSet {
            layer.borderWidth = isSelected ? Constants.borderWidth : 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with avatar: Avatar) {
        imageView.image = avatar.image
    }
    
    private func setupViews() {
        layer.masksToBounds = true
        layer.cornerRadius = Constants.cornerRadius
        layer.borderColor = Constants.borderColor.cgColor
        imageView.backgroundColor = Constants.placeholderColor
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            heightAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}
