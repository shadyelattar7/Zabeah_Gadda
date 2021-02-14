//
//  Helper.swift
//  City Butcher
//
//  Created by Elattar on 12/9/20.
//  Copyright © 2020 Elattar. All rights reserved.
//

import Foundation

class Helper{
    static func saveToken(token: String){
        let def = UserDefaults.standard
        def.set(token, forKey: UDKey.token)
        def.synchronize()
    }
    
    static func getToken() -> String?{
        let def = UserDefaults.standard
        return def.object(forKey: UDKey.token) as? String
    }
    
    static func saveCountCart(count: Int){
          let def = UserDefaults.standard
          def.set(count, forKey: UDKey.cartCount)
          def.synchronize()
      }

      static func getCountCart() -> Int?{
          let def = UserDefaults.standard
          return def.object(forKey: UDKey.cartCount) as? Int
      }
    
    
}
