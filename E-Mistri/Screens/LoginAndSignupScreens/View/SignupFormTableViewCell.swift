//
//  SignupFormTableViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 04/01/2023.
//

import UIKit

protocol SignupFormTableViewCellDelegate: AnyObject {
    func pressedSignupButton(isValid: Bool,
                             btnIsChecked: Bool,
                             signupFullName: String,
                             signupEmail: String,
                             signupPassword: String)
    func pressedSigninButton()
}

class SignupFormTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fullNameTextField: CustomTextField!
    @IBOutlet weak var userEmailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var confirmPasswordTextField: CustomTextField!
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var signupButton: CustomButton!
    @IBOutlet weak var alreadyHaveAccountText: UILabel!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var nameErrorMessage: ErrorLabel!
    @IBOutlet weak var emailErrorMessage: ErrorLabel!
    @IBOutlet weak var passwordErrorMessage: ErrorLabel!
    @IBOutlet weak var confirmPasswordErrorMessage: ErrorLabel!
    @IBOutlet weak var checkboxErrorMessage: ErrorLabel!
    @IBOutlet weak var agreementText: UITextView!
    
    static let identifier: String = "SignupFormTableViewCell"
    weak var delegate: SignupFormTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        viewComponents()
        selectionStyle = .none
    }
    
    private func viewComponents() {
        selectionStyle = .none
        
        fullNameTextField.setupTextField(placeholderText: "Full Name")
        
        userEmailTextField.setupTextField(placeholderText: "Your Email")
        
        passwordTextField.setupTextField(placeholderText: "Password")
        passwordTextField.autocorrectionType = .no
        
        confirmPasswordTextField.setupTextField(placeholderText: "Confirm Password")
        
        btnCheckBox.setImage(UIImage(named: Images.emptyCheckbox), for: .normal)
        btnCheckBox.setImage(UIImage(named: Images.filledCheckbox), for: .selected)
        btnCheckBox.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        
        agreementText.textAlignment = .left
        agreementText.attributedText = NSAttributedString.hyperlinks(for: Text.agreementUrl,
                                                                     in: Text.agreementText,
                                                                     as: "Terms of Service",
                                                                     and: "Privacy Policy")
        agreementText.font = .systemFont(ofSize: 16.0)
        agreementText.translatesAutoresizingMaskIntoConstraints = true
        agreementText.sizeToFit()
        agreementText.isScrollEnabled = false
        agreementText.textColor = .secondaryTextColor
        agreementText.isEditable = false
        
        signupButton.setupButton(buttonTitle: "Sign Up")
        signupButton.addTarget(self, action: #selector(signupButtonPressed), for: .touchUpInside)
        
        alreadyHaveAccountText.text = Text.alreadyHaveAccount
        
        signinButton.setTitle(Text.signin, for: .normal)
        signinButton.addTarget(self, action: #selector(signinPressed), for: .touchUpInside)
    }
    
    @objc private func checkboxTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                    sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                }) { _ in
                    UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                        sender.isSelected = !sender.isSelected
                        sender.transform = .identity
                    }, completion: nil)
                }
    }
    
    @objc private func signupButtonPressed() {
        let isValid = validateSignupForm()
        guard let fullName = fullNameTextField.text,
                let userMail = userEmailTextField.text,
                let userPassword = passwordTextField.text else {
            return
        }
        delegate?.pressedSignupButton(
            isValid: isValid,
            btnIsChecked: btnCheckBox.isSelected,
            signupFullName: fullName,
            signupEmail: userMail,
            signupPassword: userPassword
        )
    }
    
    @objc private func signinPressed() {
        delegate?.pressedSigninButton()
    }
    
    private func validateSignupForm() -> Bool {
        var userNameIsValid: Bool = false
        var userEmailIsValid: Bool = false
        var passwordIsValid: Bool = false
        var passwordErrorMessages: String = ""
        var confirmPasswordIsValid: Bool = false
        
        guard let userName = fullNameTextField.text else {
            return false
        }
        userNameIsValid = FormValidation.validateName(userName: userName)
        if !userNameIsValid {
            nameErrorMessage.setupLabel(errorMessage: ErrorMessages.invalidUserName)
            nameErrorMessage.isHidden = false
        } else {
            nameErrorMessage.isHidden = true
        }
        
        guard let userEmail = userEmailTextField.text else {
            return false
        }
        userEmailIsValid = FormValidation.validateEmail(userEmail: userEmail)
        if !userEmailIsValid {
            emailErrorMessage.setupLabel(errorMessage: ErrorMessages.invalidEmailAddress)
            emailErrorMessage.isHidden = false
        } else {
            emailErrorMessage.isHidden = true
        }
        
        guard let password = passwordTextField.text else {
            return false
        }
        passwordErrorMessages = FormValidation.validatePassword(password: password)
        if passwordErrorMessages != ErrorMessages.passwordIsOkay {
            passwordErrorMessage.setupLabel(errorMessage: passwordErrorMessages)
            passwordErrorMessage.isHidden = false
            passwordIsValid = false
        } else {
            passwordIsValid = true
            passwordErrorMessage.isHidden = true
        }
        
        guard let confirmPassword = confirmPasswordTextField.text else {
            return false
        }
        if confirmPassword == password {
            confirmPasswordErrorMessage.isHidden = true
            confirmPasswordIsValid = true
        } else {
            confirmPasswordErrorMessage.isHidden = false
            confirmPasswordErrorMessage.setupLabel(errorMessage: ErrorMessages.matchPassword)
            confirmPasswordIsValid = false
        }
        
        if userNameIsValid == true &&
            userEmailIsValid == true &&
            passwordIsValid == true &&
            confirmPasswordIsValid == true {
            return true
        } else {
            return false
        }
    }
}
