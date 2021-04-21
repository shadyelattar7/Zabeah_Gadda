//
//  GetMyOrders.swift
//  City Butcher
//
//  Created by Elattar on 12/12/20.
//  Copyright © 2020 Elattar. All rights reserved.
//

import Foundation
import Alamofire

class ApiManagerMyOrders{
    
    static func getMyOrders (sessionCode: String ,completion: @escaping (_ error: String?,_ Category: WelcomeMyOrder?) -> ()){
        
        let url = URLs.myOrders
        
        
        let parameter: [String: Any] = [
            "session_code": sessionCode
        ]
        
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result{
                
            case .failure(let error):
                print("Error while fetching CatrgoryList: \(error.localizedDescription)")
                completion(error.localizedDescription, nil)
            case .success(_):
                //  print(response.result.value)
                guard let data = response.data else {
                    print("Error whiles fetching data: didn't get any data from API")
                    completion("didin't get any data from API",nil)
                    return
                }
                do{
                    let categories = try JSONDecoder().decode(WelcomeMyOrder.self, from: data)
                    completion(nil,categories)
                    
                }catch{
                    print("Error trying to decode response")
                    print(error)
                    completion(error.localizedDescription,nil)
                }
            }
        }
    }
}

