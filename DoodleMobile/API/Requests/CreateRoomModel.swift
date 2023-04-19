import Foundation

struct CreateRoomModel: Encodable {
    let name: String
    let capacity: Int
    
    init(roomModel: RoomModel) {
        self.name = roomModel.name
        self.capacity = roomModel.maxNumberOfPlayers
    }
}
