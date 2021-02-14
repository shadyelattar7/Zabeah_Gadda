//
//  CategoriesModel.swift
//  JaddaButcher
//
//  Created by Elattar on 1/14/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct WelcomeCategory: Codable {
    let products: [Product]
    let status: Int?
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let name, image, categoryID, order: String?
    let imagePath: String?
    let categoryName: String?
    let prices: [Price]?
    let inCart: Int?
    let smallPrice: String?

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case categoryID = "category_id"
        case order, imagePath, categoryName, prices
        case inCart = "in_cart"
        case smallPrice = "small_price"
    }
}

// MARK: - Price
struct Price: Codable {
    let id: Int?
    let name, price, productID: String?

    enum CodingKeys: String, CodingKey {
        case id, name, price
        case productID = "product_id"
    }
}
