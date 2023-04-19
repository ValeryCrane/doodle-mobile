import Foundation
import UIKit

class RoomLobbyScreenViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        enum Measure {
            static let sideOffsets: CGFloat = 16
            static let roomNameHeight: CGFloat = 80
            static let playersTitleHeight: CGFloat = 64
        }
        enum Text {
            static let title = "Room"
            static let roomName = "Name:"
            static let players = "Players:"
        }
        enum Color {
            static let backgorund: UIColor = .white
        }
    }
    
    // MARK: Properties
    
    var output: RoomLobbyViewControllerOutput?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        return stackView
    }()
    
    private let headerView = UIView()
    
    private let roomNameTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.roomName
        return label
    }()
    
    private let roomNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    private let playersView = UIView()
    
    private let playersTitle: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.players
        return label
    }()
    
    // TODO: Фикс констреинтов
    private lazy var playersTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.register(PlayerCell.self, forCellReuseIdentifier: PlayerCell.reuseIdentifier)
        return tableView
    }()
    
    private var roomLobbyModel: RoomLobbyModel
    
    // MARK: Init
    
    init(roomLobbyModel: RoomLobbyModel) {
        self.roomLobbyModel = roomLobbyModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ViewController's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.Color.backgorund
        roomNameLabel.text = roomLobbyModel.name
        setupViewHierarchy()
        setupConstraints()
    }
    
    // MARK: Private functions
    
    private func setupViewHierarchy() {
        view.addSubview(stackView)
        [headerView, playersView, playersTableView].forEach({
            stackView.addArrangedSubview($0)
        })
        [roomNameTitle, roomNameLabel].forEach({
            headerView.addSubview($0)
        })
        playersView.addSubview(playersTitle)
    }
    
    private func setupConstraints() {
        [stackView, headerView, playersView, playersTitle, roomNameTitle, roomNameLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            roomNameTitle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            roomNameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            roomNameTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Measure.sideOffsets),
            roomNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Measure.sideOffsets),
            headerView.heightAnchor.constraint(equalToConstant: Constants.Measure.roomNameHeight),
            playersView.heightAnchor.constraint(equalToConstant: Constants.Measure.playersTitleHeight),
            playersTitle.centerYAnchor.constraint(equalTo: playersView.centerYAnchor),
            playersTitle.leadingAnchor.constraint(equalTo: playersView.leadingAnchor, constant: Constants.Measure.sideOffsets)
        ])
    }
}

// MARK: UITableViewDataSource

extension RoomLobbyScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        roomLobbyModel.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PlayerCell.reuseIdentifier,
            for: indexPath
        ) as? PlayerCell
        cell?.setup(with: roomLobbyModel.players[indexPath.row])
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
}

// MARK: RoomLobbyViewControllerInput

extension RoomLobbyScreenViewController: RoomLobbyViewControllerInput {
    func updateRoomLobbyModel(_ roomLobbyModel: RoomLobbyModel) {
        self.roomLobbyModel = roomLobbyModel
        roomNameLabel.text = roomLobbyModel.name
        playersTableView.reloadData()
    }
}

