//
//  ProfileScreenViewController.swift
//  E-Mistri
//
//  Created by gurzu on 30/01/2023.
//

import UIKit

class ProfileScreenViewController: UIViewController {

    @IBOutlet weak var goBackButton: CustomBackButton!
    @IBOutlet weak var profileScreenTitle: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var editProfileBtn: CustomButton!
    @IBOutlet weak var profileDetailsView: UIView!
    @IBOutlet weak var fullNameText: UILabel!
    @IBOutlet weak var phoneNumberText: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var emailAddressText: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var addressText: UILabel!
    @IBOutlet weak var address: UILabel!
    
    static let identifier = "ProfileScreenViewController"
    let userData: UserData = Storage.shared.load(key: Text.userKey)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewComponents()
    }
    
    private func viewComponents() {
        profileScreenTitle.text = "Profile"
        profileScreenTitle.textAlignment = .center
        
        goBackButton.setupButton(buttonImage: Images.chevronBackward)
        goBackButton.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        
        if userData.userProfilePicturePath == "" {
            profileImage.image = UIImage(named: Images.noUserImage)
        } else {
            profileImage.downloaded(from: userData.userProfilePicturePath)
        }
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.contentMode = .scaleToFill
        
        profileName.text = userData.userName
        profileName.textAlignment = .center
        
        profileEmail.text = userData.userEmail
        profileEmail.textColor = .profilepageGray
        profileEmail.textAlignment = .center
        
        editProfileBtn.setupButton(buttonTitle: "Edit Profile")
        editProfileBtn.layer.cornerRadius = editProfileBtn.frame.height / 2
        editProfileBtn.addTarget(self, action: #selector(editProfileBtnTapped), for: .touchUpInside)
        
        profileDetailsView.backgroundColor = .white
        profileDetailsView.layer.cornerRadius = 20
        profileDetailsView.layer.shadowOffset = CGSize(width: 1, height: 1)
        profileDetailsView.layer.shadowOpacity = 0.3
        profileDetailsView.layer.shadowRadius = 10.0
        profileDetailsView.clipsToBounds = false
        
        fullNameText.text = "Full Name"
        fullNameText.textColor = .profilepageGray
        
        fullName.text = userData.userName
        
        phoneNumberText.text = "Phone Number"
        phoneNumberText.textColor = .profilepageGray
        
        if userData.userPhoneNumber == Text.defaultPhoneNumber {
            phoneNumber.text = "N/A"
        } else {
            phoneNumber.text = userData.userPhoneNumber
        }
        
        emailAddressText.text = "Email Address"
        emailAddressText.textColor = .profilepageGray
        
        emailAddress.text = userData.userEmail
        
        addressText.text = "Address"
        addressText.textColor = .profilepageGray
        
        if userData.userAddress == nil {
            address.text = "N/A"
        } else {
            address.text = userData.userAddress
        }
    }
    
    @objc private func backBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func editProfileBtnTapped() {
        let editProfileScreenStoryboard = UIStoryboard(name: Storyboards.EditProfileScreen, bundle: nil)
        guard let viewController = editProfileScreenStoryboard.instantiateViewController(
            withIdentifier: EditProfileViewController.identifier
        ) as? EditProfileViewController else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
}
