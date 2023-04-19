import Foundation

class CreateRoomRequest: HttpRequest {
    typealias Response = RoomStompResponse
    
    let query: String = "/rooms"
    let method: HttpMethod = .post
    let parameters: Encodable? = nil
    var body: Encodable?
    
    func setup(with createRoomModel: CreateRoomModel) {
        body = createRoomModel
    }
}
