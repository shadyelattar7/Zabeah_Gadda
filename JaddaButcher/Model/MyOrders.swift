//
//  MyOrders.swift
//  JaddaButcher
//
//  Created by Elattar on 1/17/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct WelcomeMyOrder: Codable {
    let status: Int?
    let data: [DateMyOrder]?
}

// MARK: - Datum
struct DateMyOrder: Codable {
    let id: Int?
    let name, phone, address, postalCode: String?
    let payMethod, deliverTime, totalPrice, sessionCode: String?
    let statusID: Int?
    let notes: String?
    let createdAt, updatedAt: String?
    let details: [DetailMyOrder]?

    enum CodingKeys: String, CodingKey {
        case id, name, phone, address
        case postalCode = "postal_code"
        case payMethod = "pay_method"
        case deliverTime = "deliver_time"
        case totalPrice = "total_price"
        case sessionCode = "session_code"
        case statusID = "status_id"
        case notes
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case details
    }
}

// MARK: - Detail
struct DetailMyOrder: Codable {
    let id: Int?
    let productID: Int?
    let  orderID, quantity, price: String?
    let size, total: String?
    let notes, head, minced, parts: String?
    let meatPackage, soupKilos, mincedKilos, kersh: String?
    let createdAt, updatedAt: String?
    let product: ProductMyOrder?

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case orderID = "order_id"
        case quantity, price, size, total, notes, head, minced, parts
        case meatPackage = "meat_package"
        case soupKilos = "soup_kilos"
        case mincedKilos = "minced_kilos"
        case kersh
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case product
    }
}

// MARK: - Product
struct ProductMyOrder: Codable {
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
struct PriceMyOrder: Codable {
    let id: Int?
    let name, price, productID: String?

    enum CodingKeys: String, CodingKey {
        case id, name, price
        case productID = "product_id"
    }
}

