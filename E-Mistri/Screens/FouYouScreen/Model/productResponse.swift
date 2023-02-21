//
//  productResponse.swift
//  E-Mistri
//
//  Created by gurzu on 15/02/2023.
//

import Foundation

//    struct Products: Codable {
//        let  id: Int
//        let name: String
//        let price: Float
//        let categoryID: Int
//        let productDescription: String
//        let rating: Float
//        let productImagePath: String
//        enum CodingKeys: String, CodingKey {
//            case id
//            case name
//            case price
//            case categoryID = "category_id"
//            case productDescription = "description"
//            case rating
//            case productImagePath = "image_path"
//        }
//    }

struct Products: Codable {
    let  id: Int
    let name: String
    let price: Float
    let categoryID: Int
    let productDescription: String
    let productRating: Float
    let productImagePath: String
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case categoryID = "category_id"
        case productDescription = "product_description"
        case productRating = "product_rating"
        case productImagePath = "product_image_path"
    }
}
