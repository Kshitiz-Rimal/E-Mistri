//
//  editProfileResponse.swift
//  E-Mistri
//
//  Created by gurzu on 09/02/2023.
//

import Foundation

struct EditProfileResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case address
        case displayPicturePath = "display_picture_path"
    }
    let id: Int
    let email: String
    let fullName: String
    let phoneNumber: String
    let address: String
    let displayPicturePath: String
}

struct DisplayPicturePathResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case displayPicturePath = "display_picture_path"
    }
    let displayPicturePath: String
}
