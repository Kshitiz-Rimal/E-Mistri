//
//  AddToCartRequest.swift
//  E-Mistri
//
//  Created by gurzu on 17/02/2023.
//

import Foundation

struct AddToCartRequest: Codable {
    let product: ProductDetail
}

struct ProductDetail: Codable {
    let productId: Int
    let quantity: Int
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case quantity
    }
}
