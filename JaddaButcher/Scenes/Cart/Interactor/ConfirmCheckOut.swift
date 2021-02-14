//
//  ConfirmCheckOut.swift
//  City Butcher
//
//  Created by Elattar on 12/9/20.
//  Copyright © 2020 Elattar. All rights reserved.
//

import Foundation
import Alamofire

class ApiManagerCheckout{
    
    static func checkout (session_code: String, name: String, phone: String,address: String, postal_code: String, pay_method: String, deliver_time: String,completion: @escaping (_ error: String?, _ succss: Checkout?) -> ()){
        
        let url = URLs.checkout(session_code, name, phone,address,postal_code,pay_method,deliver_time)
        
        
        Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result{
                    
                case .failure(let error):
                    print("Error while fetching data: \(error.localizedDescription)")
                    completion(error.localizedDescription, nil)
                case .success(_):
                    print(response.result.value)
                    guard let data = response.data else {
                        print("Error whiles fetching data: didn't get any data from API")
                        completion("didin't get any data from API",nil)
                        return
                    }
                    do{
                        let token = try JSONDecoder().decode(Checkout.self, from: data)
                        completion(nil,token)
                    }catch{
                        print("Error trying to decode response")
                        print(error)
                        completion(error.localizedDescription,nil)
                    }
                    
                }
        }
        
    }
    
    
}

