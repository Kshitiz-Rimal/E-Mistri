//
//  SignUpRequest.swift
//  E-Mistri
//
//  Created by gurzu on 01/02/2023.
//

import Foundation

struct SignupDetails: Codable {
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case email
        case password
    }
    let fullName: String
    let email: String
    let password: String
}

struct CustomerSignUp: Codable {
    let customer: SignupDetails
}
