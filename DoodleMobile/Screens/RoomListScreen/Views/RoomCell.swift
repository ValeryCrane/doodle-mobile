import Foundation
import UIKit

class RoomCell: UITableViewCell {
    static let reuseIdentifier = "RoomCell"
    
    private enum Constants {
        static let prefferedHeight: CGFloat = 64
        static let sideOffsets: CGFloat = 16
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let numberOfPlayersLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViewHierarchy()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with roomModel: RoomModel) {
        nameLabel.text = roomModel.name
        numberOfPlayersLabel.text = "\(roomModel.currentNumberOfPlayers)/\(roomModel.maxNumberOfPlayers)"
    }
    
    private func setupViewHierarchy() {
        addSubview(nameLabel)
        addSubview(numberOfPlayersLabel)
    }
    
    private func setupConstraints() {
        [nameLabel, numberOfPlayersLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberOfPlayersLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.sideOffsets),
            numberOfPlayersLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.sideOffsets),
            heightAnchor.constraint(equalToConstant: Constants.prefferedHeight)
        ])
    }
}
