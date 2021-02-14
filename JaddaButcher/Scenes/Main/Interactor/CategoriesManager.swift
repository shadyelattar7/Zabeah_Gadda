//
//  CategoriesManager.swift
//  JaddaButcher
//
//  Created by Elattar on 1/14/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import Foundation
import Alamofire

class APIManagerCategorie{
    static func categoryList (completion: @escaping (_ Category: WelcomeCategory) -> ()){
        
        let url = URLs.Category
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result{
                
            case .failure(let error):
                print("Error while fetching ProductList: \(error.localizedDescription)")
             //   completion(nil)
            case .success(_):
               //   print(response.result.value)
                guard let data = response.data else {
                    print("Error whiles fetching data: didn't get any data from API")
                  //  completion(nil)
                    return
                }
                do{
                    let categories = try JSONDecoder().decode(WelcomeCategory.self, from: data)
                    completion(categories)
                    
                }catch{
                    print("Error trying to decode response: \(error.localizedDescription)")
                 //   completion(nil)
                }
            }
        }
    }
}
