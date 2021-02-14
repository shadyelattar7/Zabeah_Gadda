//
//  AddToCart.swift
//  JaddaButcher
//
//  Created by Elattar on 1/17/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct WelcomeAddToCart: Codable {
    
    let message: String?
    let sessionCode: String?
    let status: Int
    let errors: [String]?
    
    enum CodingKeys: String, CodingKey {
        case message
        case sessionCode = "session_code"
        case status
        case errors
    }
}

//// MARK: - Welcome
//struct WelcomeAddToCart: Codable {
//    let message: String?
//    let data: DataAddToCart?
//    let sessionCode: String?
//    let status: Int?
//    let errors: [String]?
//
//    enum CodingKeys: String, CodingKey {
//        case message, data
//        case sessionCode = "session_code"
//        case status
//        case errors
//    }
//}
//
//// MARK: - DataClass
//struct DataAddToCart: Codable {
//
//    let productID, quantity, sessionCode: String?
//    //  let meatPackage, parts, head, kersh: String?
//  //  let minced: String?
//    let size, price: String?
//    //  let notes: String?
//    //    let mincedKilos: String?
//    let mincedPrice: Int?
//    //   let soupKilos: String?
//    let soupPrice, total, id: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case productID = "product_id"
//        case quantity
//        case sessionCode = "session_code"
//        //  case meatPackage = "meat_package"
//        //   case parts, head, kersh, minced
//        case size, price
//        // case notes
//        //   case mincedKilos = "minced_kilos"
//        case mincedPrice = "minced_price"
//        //   case soupKilos = "soup_kilos"
//        case soupPrice = "soup_price"
//        case total, id
//    }
//}
//
//
