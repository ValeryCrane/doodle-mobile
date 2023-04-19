import Foundation
import UIKit

protocol EditProfileViewControllerInput: UIViewController { }

protocol EditProfileViewControllerOutput {
    func saveProfileModel(_ profileModel: EditProfileViewModel)
}

class EditProfilePresenter: EditProfileViewControllerOutput {
    
    weak var view: EditProfileViewControllerInput?
    
    private let saveProfileRequest = SaveProfileRequest()
    
    func saveProfileModel(_ profileModel: EditProfileViewModel) {
        view?.startLoading()
        saveProfileRequest.setup(with: .init(with: profileModel))
        saveProfileRequest.send(
            success: { _ in
                print("HOORAY")
            },
            fail: { _ in
                print("NOOO")
            },
            finally: { [weak self] in
                DispatchQueue.main.async {
                    self?.view?.stopLoading()
                }
            }
        )
    }
}


