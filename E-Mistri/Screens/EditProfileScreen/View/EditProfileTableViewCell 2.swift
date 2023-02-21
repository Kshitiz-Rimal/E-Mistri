//
//  EditProfileTableViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 03/02/2023.
//

import UIKit

protocol EditProfileTableViewCellDelegate: AnyObject {
    func tappedEditProfileButton(isOkay: Bool, name: String, phoneNum: String, address: String)
}

class EditProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var fullNameTextField: CustomTextField!
    @IBOutlet weak var fullNameErrorMessage: ErrorLabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: CustomTextField!
    @IBOutlet weak var phoneNumberErrorMessage: ErrorLabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressTextField: CustomTextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var editProfileButton: CustomButton!
    
    static let identifier: String = "EditProfileTableViewCell"
    let userData: UserData = Storage.shared.load(key: Text.userKey)
    weak var delegate: EditProfileTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewComponents()
    }
    
    private func viewComponents() {
        fullNameLabel.text = "Full Name"
        fullNameLabel.textColor = .editProfileBlue
        
        fullNameTextField.text = userData.userName
        
        phoneNumberLabel.text = "Phone Number"
        
        if userData.userPhoneNumber == Text.defaultPhoneNumber {
            phoneNumberTextField.text = "N/A"
        } else {
            phoneNumberTextField.text = userData.userPhoneNumber
        }
        phoneNumberTextField.keyboardType = .numberPad
        
        addressLabel.text = "Address"
        
        if userData.userAddress == nil {
            addressTextField.text = "N/A"
        } else {
            addressTextField.text = userData.userAddress
        }
        
        emailLabel.text = "Email"
        emailTextField.text = userData.userEmail
        emailTextField.isEnabled = false
        
        editProfileButton.setupButton(buttonTitle: "Edit Profile")
        editProfileButton.addTarget(self, action: #selector(editProfileButtonTapped), for: .touchUpInside)
    }
    
    @objc private func editProfileButtonTapped() {
        let isOkay = validateEditedDetails()
        guard let fullName = fullNameTextField.text,
              let phNumber = phoneNumberTextField.text,
              let address = addressTextField.text else {
            return
        }
        delegate?.tappedEditProfileButton(isOkay: isOkay, name: fullName, phoneNum: phNumber, address: address)
    }
    
    private func validateEditedDetails() -> Bool {
        var userNameIsValid: Bool = false
        var phoneNumberIsValid: Bool = false
        
        guard let userName = fullNameTextField.text else {
            return false
        }
        userNameIsValid = FormValidation.validateName(userName: userName)
        if !userNameIsValid {
            fullNameErrorMessage.setupLabel(errorMessage: ErrorMessages.invalidUserName)
            fullNameErrorMessage.isHidden = false
        } else {
            fullNameErrorMessage.isHidden = true
        }
        
        guard let phoneNumber = phoneNumberTextField.text else {
            return false
        }
        phoneNumberIsValid = FormValidation.validatePhoneNumber(phoneNumber: phoneNumber)
        if !phoneNumberIsValid {
            phoneNumberErrorMessage.setupLabel(errorMessage: ErrorMessages.invalidPhoneNumber)
            phoneNumberErrorMessage.isHidden = false
        } else {
            phoneNumberErrorMessage.isHidden = true
        }
        
        if userNameIsValid == true && phoneNumberIsValid == true {
            return true
        } else {
            return false
        }
    }
}
