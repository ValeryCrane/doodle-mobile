import Foundation

class SaveProfileRequest: HttpRequest {
    typealias Response = EmptyResponse
    
    let query: String = "/players"
    let method: HttpMethod = .post
    let parameters: Encodable? = nil
    var body: Encodable?
    
    func setup(with saveProfileModel: SaveProfileModel) {
        body = saveProfileModel
    }
}
