//
//  FormValidation.swift
//  E-Mistri
//
//  Created by gurzu on 12/01/2023.
//

import Foundation

struct FormValidation {
    static func validateName(userName: String) -> Bool {
        if !NSPredicate(
            format: "SELF MATCHES %@",
            "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$"
        ).evaluate(with: userName) {
            return false
        } else {
            return true
        }
    }
    
    static func validateEmail(userEmail: String) -> Bool {
        if !NSPredicate(format: "SELF MATCHES %@",
                                "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: userEmail) {
            return false
        } else {
            return true
        }
    }
    
    static func validatePassword(password: String) -> String {
        if !NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: password) {
            return ErrorMessages.atleastOneUppercase
        } else if !NSPredicate(format: "SELF MATCHES %@", ".*[!@#$&*]+.*").evaluate(with: password) {
            return ErrorMessages.atleastOneSpecialCharacter
        } else if !NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: password) {
            return ErrorMessages.atleastOneNumber
        } else if !NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*").evaluate(with: password) {
            return ErrorMessages.lowercaseLetter
        } else if password.count < 8 {
            return ErrorMessages.atleastEightCharacter
        } else {
            return ErrorMessages.passwordIsOkay
        }
    }
    
    static func validatePhoneNumber(phoneNumber: String) -> Bool {
        if phoneNumber.count != 10 {
            return false
        } else {
            return true
        }
    }
}
