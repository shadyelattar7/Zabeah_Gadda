//
//  CartModel.swift
//  JaddaButcher
//
//  Created by Elattar on 1/17/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct WelcomeCart: Codable {
    let carts: [Cart]
    let status: Int?
}

// MARK: - Cart
struct Cart: Codable {
    let id: Int?
    let productID: Int?
    let parts: String?
    let sessionCode, quantity, size, price: String?
    let notes: String?
    let total: String?
    let meatPackage, head, minced, mincedKilos: String?
    let mincedPrice: String?
    let soupKilos: String?
    let soupPrice: String?
    let kersh: String?
    let product: Product?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case parts
        case sessionCode = "session_code"
        case quantity, size, price, notes, total
        case meatPackage = "meat_package"
        case head, minced
        case mincedKilos = "minced_kilos"
        case mincedPrice = "minced_price"
        case soupKilos = "soup_kilos"
        case soupPrice = "soup_price"
        case kersh, product
    }
}

// MARK: - Product
struct ProductCart: Codable {
    let id: Int?
    let name, image, categoryID, order: String?
    let imagePath: String?
    let categoryName: String?
    let prices: [Price]?

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case categoryID = "category_id"
        case order, imagePath, categoryName, prices
    }
}

// MARK: - Price
struct PriceCart: Codable {
    let id: Int?
    let name, price, productID: String?

    enum CodingKeys: String, CodingKey {
        case id, name, price
        case productID = "product_id"
    }
}



