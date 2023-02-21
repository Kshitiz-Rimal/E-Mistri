//
//  UserData.swift
//  E-Mistri
//
//  Created by gurzu on 06/02/2023.
//

import UIKit

struct UserData: Codable {
    var userId: Int
    var userName: String
    var userEmail: String
    var userPhoneNumber: String
    var userAddress: String?
    var userIsActive: Bool
    var userProfilePicturePath: String
}
