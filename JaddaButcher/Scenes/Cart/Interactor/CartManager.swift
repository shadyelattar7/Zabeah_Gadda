//
//  CartManager.swift
//  JaddaButcher
//
//  Created by Elattar on 1/17/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import Foundation
import Alamofire

class APIManagerGetCart{
    
    static func getCart ( sessionCode: String ,completion: @escaping (_ error: String?, _ succss: WelcomeCart?) -> ()){
        
        let url = URLs.getCart
        
        let parameter: [String: Any] = [
            "session_code": sessionCode
        ]
        
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.httpBody, headers: nil)
            .responseJSON { (response) in
                switch response.result{
                    
                case .failure(let error):
                    // print("Error while fetching data: \(error.localizedDescription)")
                    completion("Error while fetching data: \(error.localizedDescription)", nil)
                case .success(_):
                     print(response.result.value)
                    guard let data = response.data else {
                        //  print("Error whiles fetching data: didn't get any data from API")
                        completion("Error whiles fetching data: didn't get any data from API",nil)
                        return
                    }
                    do{
                        let token = try JSONDecoder().decode(WelcomeCart.self, from: data)
                        completion(nil,token)
                    }catch{
                        // print("Error trying to decode response, \(error.localizedDescription)")
                        completion("Error trying to decode response, \(error.localizedDescription)",nil)
                    }
                    
                }
        }
        
    }
    
    
}
