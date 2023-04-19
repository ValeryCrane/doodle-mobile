import Foundation

struct RoomLobbyModel {
    let name: String
    let players: [PlayerModel]
    
    init(with roomStompResponse: RoomStompResponse) {
        self.name = roomStompResponse.name
        self.players = roomStompResponse.players.map({ .init(name: $0.username) })
    }
}
