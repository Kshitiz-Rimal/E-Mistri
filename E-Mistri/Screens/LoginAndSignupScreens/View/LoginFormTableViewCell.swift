//
//  LoginFormTableViewCell.swift
//  E-Mistri
//
//  Created by gurzu on 04/01/2023.
//

import UIKit

protocol LoginFormTableViewCellDelegate: AnyObject {
    func tappedLoginButton(isOkay: Bool,
                           signupEmail: String,
                           signupPassword: String)
    func tappedJoinUsButton()
}

class LoginFormTableViewCell: UITableViewCell {

    @IBOutlet weak var userEmailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var dontHaveAccountText: UILabel!
    @IBOutlet weak var joinUsButton: UIButton!
    @IBOutlet weak var userEmailErrorLabel: ErrorLabel!
    @IBOutlet weak var passwordErrorLabel: ErrorLabel!
    
    static let identifier: String = "LoginFormTableViewCell"
    weak var delegate: LoginFormTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewComponents()
    }
    
    private func viewComponents() {
        selectionStyle = .none
        
        userEmailTextField.setupTextField(placeholderText: Text.usernameTextField)
        passwordTextField.setupTextField(placeholderText: Text.passWordTextField)
        
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.systemFont(ofSize: 40.0, weight: .bold)
        forgotPasswordButton.titleLabel?.font = Fonts.forgotPasswordBtnTitleFont
        loginButton.setupButton(buttonTitle: "Login")
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        dontHaveAccountText.text = Text.dontHaveAccount
        
        joinUsButton.setTitle(Text.joinUs, for: .normal)
        joinUsButton.addTarget(self, action: #selector(joinUsButtonPressed), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        let isOkay = loginFieldValidation()
        guard let userMail = userEmailTextField.text,
              let userPassword = passwordTextField.text else {
            return
        }
        delegate?.tappedLoginButton(isOkay: isOkay,
                                    signupEmail: userMail,
                                    signupPassword: userPassword)
    }
    
    @objc private func joinUsButtonPressed() {
        delegate?.tappedJoinUsButton()
    }
    
    private func loginFieldValidation() -> Bool {
        var userEmailIsValid: Bool = false
        var passwordIsValid: Bool = false
        guard let userEmail = userEmailTextField.text else {
            return false
        }
        userEmailIsValid = FormValidation.validateEmail(userEmail: userEmail)
        if !userEmailIsValid {
            userEmailErrorLabel.setupLabel(errorMessage: ErrorMessages.invalidEmailAddress)
            userEmailErrorLabel.isHidden = false
        } else {
            userEmailErrorLabel.isHidden = true
        }
        
        guard let password = passwordTextField.text else {
            return false
        }
        if password.isEmpty {
            passwordErrorLabel.setupLabel(errorMessage: ErrorMessages.emptyPasswordField)
            passwordErrorLabel.isHidden = false
            passwordIsValid = false
        } else {
            passwordErrorLabel.isHidden = true
            passwordIsValid = true
        }
        
        if userEmailIsValid == true && passwordIsValid == true {
            return true
        } else {
            return false
        }
    }
}
