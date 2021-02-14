//
//  Checkout.swift
//  City Butcher
//
//  Created by Elattar on 12/10/20.
//  Copyright © 2020 Elattar. All rights reserved.
//

import Foundation

struct Checkout: Codable {
    
    let orderID, status: Int?
    let errors: [String]?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case status
        case errors
        case message
    }
}
