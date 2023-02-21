//
//  APIData.swift
//  E-Mistri
//
//  Created by gurzu on 30/01/2023.
//

import Foundation

struct LoginDetails: Codable {
    enum CodingKeys: String, CodingKey {
        case email
        case password
    }
    let email: String
    let password: String
}

struct CustomerSignin: Codable {
    let customer: LoginDetails
}
