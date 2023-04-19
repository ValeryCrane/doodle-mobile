import Foundation

struct PlayersInRoomStompMessage: Decodable {
    let id: Int
    let username: String
    let avatar: String
}

struct RoomStompResponse: Decodable {
    let id: Int
    let name: String
    let capacity: Int
    let players: [PlayersInRoomStompMessage]
}
