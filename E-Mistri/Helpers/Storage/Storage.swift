//
//  Storage.swift
//  E-Mistri
//
//  Created by gurzu on 06/02/2023.
//

import Foundation

class Storage {
    static let shared = Storage()
    private let defaults = UserDefaults.standard
     
    func save(value: UserData, key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            UserDefaults.standard.set(data, forKey: key)
        } catch let error {
            print("Error encoding: \(error)")
        }
    }
    
    func load(key: String) -> UserData {
        do {
            if let data = UserDefaults.standard.data(forKey: key) {
                let user = try JSONDecoder().decode(UserData.self, from: data)
                return user
            }
        } catch let error {
            print("Error decoding: \(error)")
            return UserData(userId: 0,
                            userName: "",
                            userEmail: "",
                            userPhoneNumber: "",
                            userAddress: "",
                            userIsActive: false,
                            userProfilePicturePath: "")
        }
        return UserData(userId: 0,
                        userName: "",
                        userEmail: "",
                        userPhoneNumber: "",
                        userAddress: "",
                        userIsActive: false,
                        userProfilePicturePath: "")
    }
}
