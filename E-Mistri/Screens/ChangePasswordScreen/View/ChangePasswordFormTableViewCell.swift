//
//  ChangePasswordFormTableViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 01/02/2023.
//

import UIKit

protocol ChangePasswordFormTableViewCellDelegate: AnyObject {
    func tappedSaveButton(isOkay: Bool)
}

class ChangePasswordFormTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currentPasswordLabel: UILabel!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var currentPasswordTextField: CustomTextField!
    @IBOutlet weak var currentPasswordErrorMessage: ErrorLabel!
    @IBOutlet weak var newPasswordLabel: UILabel!
    @IBOutlet weak var newPasswordTextField: CustomTextField!
    @IBOutlet weak var newPassWordErrorLabel: ErrorLabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: CustomTextField!
    @IBOutlet weak var confirmPasswordNewLabel: ErrorLabel!
    @IBOutlet weak var saveChangesButton: CustomButton!

    static let identifier: String = "ChangePasswordFormTableViewCell"
    weak var delegate: ChangePasswordFormTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewComponents()
        selectionStyle = .none
    }
    
    private func viewComponents() {
        currentPasswordLabel.text = Text.currentPassword
        currentPasswordLabel.textColor = .changePasswordTextColor
        
        forgetPasswordButton.setTitle(Text.forgotPasswordButton, for: .normal)
        
        currentPasswordTextField.setupTextField(placeholderText: Text.changePasswordPlaceholder)
        
        newPasswordLabel.text = Text.newPassWord
        newPasswordLabel.textColor = .changePasswordTextColor
        
        newPasswordTextField.setupTextField(placeholderText: Text.changePasswordPlaceholder)
        
        confirmPasswordLabel.text = Text.confirmPassword
        confirmPasswordLabel.textColor = .changePasswordTextColor
        
        confirmPasswordTextField.setupTextField(placeholderText: Text.changePasswordPlaceholder)
        
        saveChangesButton.setupButton(buttonTitle: Text.saveChanges)
        saveChangesButton.layer.cornerRadius = saveChangesButton.frame.height / 2
        saveChangesButton.addTarget(self, action: #selector(tappedSaveChanges), for: .touchUpInside)
    }
    
    @objc private func tappedSaveChanges() {
        let isOkay = passwordFieldValidation()
        delegate?.tappedSaveButton(isOkay: isOkay)
    }
    
    private func passwordFieldValidation() -> Bool {
        var currentPasswordIsValid: Bool = false
        var newPasswordIsValid: Bool = false
        var confirmNewPassword: Bool = false
        var currentPasswordErrorMessages: String = ""
        var newPasswordErrorMessages: String = ""
        
        guard let currentPassword = currentPasswordTextField.text else {
            return false
        }
        currentPasswordErrorMessages = FormValidation.validatePassword(password: currentPassword)
        if currentPasswordErrorMessages != ErrorMessages.passwordIsOkay {
            currentPasswordErrorMessage.setupLabel(errorMessage: currentPasswordErrorMessages)
            currentPasswordErrorMessage.isHidden = false
            currentPasswordIsValid = false
        } else {
            currentPasswordIsValid = true
            currentPasswordErrorMessage.isHidden = true
        }
        
        guard let newPassword = newPasswordTextField.text else {
            return false
        }
        newPasswordErrorMessages = FormValidation.validatePassword(password: newPassword)
        if newPasswordErrorMessages != ErrorMessages.passwordIsOkay {
            newPassWordErrorLabel.setupLabel(errorMessage: newPasswordErrorMessages)
            newPassWordErrorLabel.isHidden = false
            newPasswordIsValid = false
        } else {
            newPasswordIsValid = true
            newPassWordErrorLabel.isHidden = true
        }
        
        guard let confirmPassword = confirmPasswordTextField.text else {
            return false
        }
        if confirmPassword == newPassword {
            confirmPasswordNewLabel.isHidden = true
            confirmNewPassword = true
        } else {
            confirmPasswordNewLabel.isHidden = false
            confirmPasswordNewLabel.setupLabel(errorMessage: ErrorMessages.matchPassword)
            confirmNewPassword = false
        }
        
        if  currentPasswordIsValid == true &&
            newPasswordIsValid == true &&
            confirmNewPassword == true {
            return true
        } else {
            return false
        }
    }
}
