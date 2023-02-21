//
//  KeyChain.swift
//  E-Mistri
//
//  Created by gurzu on 03/02/2023.
//

import Foundation
import KeychainSwift

let keychain = KeychainSwift()

struct KeyChain {
    static func setKeyChain(userToken: String) {
        keychain.set(userToken, forKey: Text.tokenHeader)
    }
    
    static func getKeyChain() -> String {
        guard let userToken = keychain.get(Text.tokenHeader) else { return "" }
        return userToken
    }
}
