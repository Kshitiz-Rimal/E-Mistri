//
//  AddToCartResponse.swift
//  E-Mistri
//
//  Created by gurzu on 17/02/2023.
//

import Foundation

struct AddToCartResponse: Codable {
    let customerId: Int
    let total: Float
    let id: Int
    let products: ProdDetails
    enum CodingKeys: String, CodingKey {
        case customerId = "customer_id"
        case total
        case id
        case products
    }
}

struct ProdDetails: Codable {
    let id: Int
    let name: Int
    let price: Float
    let quantity: Int
}
