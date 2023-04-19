import Foundation

struct SaveProfileModel: Encodable {
    let username: String
    let avatar: String
    
    init(with editProfileViewModel: EditProfileViewModel) {
        self.username = editProfileViewModel.username
        self.avatar = editProfileViewModel.avatar.rawValue
    }
}
