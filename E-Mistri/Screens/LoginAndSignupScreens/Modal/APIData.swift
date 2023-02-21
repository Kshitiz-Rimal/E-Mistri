//
//  APIData.swift
//  E-Mistri
//
//  Created by gurzu on 30/01/2023.
//

import Foundation

struct TodoResponse: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
