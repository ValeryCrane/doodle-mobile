import Foundation
import UIKit

class PlayerCell: UITableViewCell {
    static let reuseIdentifier = "PlayerCell"
    
    private enum Constants {
        static let sideOffsets: CGFloat = 16
        static let prefferesHeight: CGFloat = 64
    }
    
    private let nameLabel: UILabel = .init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViewHierarchy()
        setupConstraints()
    }
    
    func setup(with playerModel: PlayerModel) {
        nameLabel.text = playerModel.name
    }
    
    private func setupViewHierarchy() {
        addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sideOffsets),
            heightAnchor.constraint(equalToConstant: Constants.prefferesHeight)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
