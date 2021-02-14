//
//  ConstantsUrl.swift
//  City Butcher
//
//  Created by Elattar on 12/8/20.
//  Copyright © 2020 Elattar. All rights reserved.
//

import Foundation


class URLs{
    //BaseUrl
    private static let main = "https://pomac.info/zabaeh_gadah/public/api/"
    ///Get Category , Filter
    static let Category = main + "products"
    ///Get Product Image
    static let getImage: (_ imageName: String) -> String = { imageName in
        return "https://pomac.info/zabaeh_gadah/public/\(imageName)"
    }
    ///Post AddToCart
    static let addToCart = main + "cart/add"
    ///Get Cart
    static let getCart = main + "cart"
    /// Post Update Quantity In Cart
    static let updateQuantityInCart  = main + "cart/update"
    ///Post delete cart
    static let deleteCart = main + "cart/delete"
    ///Post Checkout
    static let checkout: (_ sessionCode:String,_ name: String,_ phone: String,_ address: String,_ postal_code: String,_ pay_method: String,_ deliver_time: String) -> String  = { sessionCode, name, phone, address, postal_code, pay_method, deliver_time in
        return main + "confirm_checkout?session_code=\(sessionCode)&name=\(name)&phone=\(phone)&address=\(address)&postal_code=9999&pay_method=\(pay_method)&deliver_time=\(deliver_time)"
    }
    
    static let myOrders = main + "myorders"
}

