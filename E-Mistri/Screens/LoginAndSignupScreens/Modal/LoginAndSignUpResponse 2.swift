//
//  SignUpResponse.swift
//  E-Mistri
//
//  Created by gurzu on 01/02/2023.
//

import Foundation

struct Data: Codable {
    let id: Int?
    let email: String?
    let createdAt: String?
    let updatedAt: String?
    let jti: String?
    let fullName: String?
    let phoneNumber: String?
    let address: String?
    let roles: String?
    let displayPicturePath: String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case jti = "jti"
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case address = "address"
        case roles = "roles"
        case displayPicturePath = "display_picture_path"
    }
}

struct AllInformation: Codable {
    let code: Int?
    let message: String?
    let data: Data?
}

struct LoginAndSignUpResponse: Codable {
    let status: AllInformation?
}

struct Headers: Codable {
    enum CodingKeys: String, CodingKey {
        case authorization = "Authorization"
    }
    let authorization: String?
}
