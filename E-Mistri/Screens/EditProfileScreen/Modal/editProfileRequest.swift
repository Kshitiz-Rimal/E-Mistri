//
//  editProfileRequest.swift
//  E-Mistri
//
//  Created by gurzu on 09/02/2023.
//

import Foundation

struct Customer: Codable {
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case address
    }
    let fullName: String
    let phoneNumber: String
    let address: String
}
