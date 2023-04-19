import Foundation
import UIKit

class RoomListViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let title = "Rooms"
    }
    
    // MARK: Properties
    
    var output: RoomListViewControllerOutput?
    
    private let loader = Loader()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private lazy var roomTableView: UITableView  = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.register(RoomCell.self, forCellReuseIdentifier: RoomCell.reuseIdentifier)
        return tableView
    }()
    
    private var rooms: [RoomModel] = []
    
    // MARK: ViewController's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.title
        setupViewHierarchy()
        setupConstraints()
        output?.startUpdating()
        activityIndicator.startAnimating()
    }
    
    // MARK: Private functions
    
    private func setupViewHierarchy() {
        view.addSubview(roomTableView)
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        [roomTableView, activityIndicator].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        NSLayoutConstraint.activate([
            roomTableView.topAnchor.constraint(equalTo: view.topAnchor),
            roomTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            roomTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            roomTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: RoomListViewControllerInput

extension RoomListViewController: RoomListViewControllerInput {
    func updateRooms(_ rooms: [RoomModel]) {
        self.rooms = rooms
        roomTableView.reloadData()
        activityIndicator.stopAnimating()
    }
}

// MARK: UITableViewDataSource

extension RoomListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: RoomCell.reuseIdentifier,
            for: indexPath
        ) as? RoomCell
        cell?.setup(with: rooms[indexPath.row])
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
}

// MARK: UITableViewDelegate

extension RoomListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.selectedRoom(rooms[indexPath.row])
    }
}


