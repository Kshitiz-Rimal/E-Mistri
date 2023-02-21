//
//  CustomTextField.swift
//  E-Mistri
//
//  Created by gurzu on 02/01/2023.
//

import UIKit

class CustomTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 28)
    let rightButton  = UIButton(type: .custom)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTextField()
    }
    
    func setupTextField(placeholderText: String) {
        if placeholderText == Text.searchTextFieldText {
            if  let image: UIImage = UIImage(systemName: Images.searchBarImagge) {
                let imageView = UIImageView(frame: CGRect(x: 7.0, y: 9.0, width: 20, height: 20))
                imageView.image = image
                imageView.tintColor = .textFieldPlaceholderColor
                imageView.contentMode = .scaleAspectFit
                
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                view.addSubview(imageView)
                leftViewMode = UITextField.ViewMode.always
                leftView = view
            }
        }
        if placeholderText == Text.passWordTextField ||
            placeholderText == "Password" ||
            placeholderText == "Confirm Password" ||
            placeholderText == Text.changePasswordPlaceholder {
                rightButton.setImage(UIImage(named: "passwordShow"), for: .normal)
                rightButton.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)
            rightButton.frame = CGRect(x: 7.0, y: 9.0, width: 20, height: 20)
                isSecureTextEntry = true
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                view.addSubview(rightButton)
                rightViewMode = UITextField.ViewMode.always
                rightView = view
        }
        let placeholderColor: UIColor = .textFieldPlaceholderColor
        attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
    }
    
    @objc func toggleShowHide(button: UIButton) {
        toggleShowOrHidePassword()
    }

    func toggleShowOrHidePassword() {
        isSecureTextEntry = !isSecureTextEntry
        if isSecureTextEntry {
            rightButton.setImage(UIImage(named: "passwordShow"), for: .normal)
        } else {
            rightButton.setImage(UIImage(named: "passwordHide"), for: .normal)
        }
    }
    
    private func configureTextField() {
        backgroundColor = .textFieldBackgroundColor
    }
}
