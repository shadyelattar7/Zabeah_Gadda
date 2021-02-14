//
//  banner.swift
//  JaddaButcher
//
//  Created by Elattar on 2/7/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import Foundation
import Alamofire


class ApiManagerBannner{
    
    static func banner ( completion: @escaping (_ error: String?,_ Category: WelcomeBanners?) -> ()){
        
        let url = "https://pomac.info/zabaeh_gadah/public/api/banners"
        
        Alamofire.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case .failure(let error):
                print("Error while fetching ProductList: \(error.localizedDescription)")
                completion(error.localizedDescription, nil)
            case .success(_):
                //  print(response.result.value)
                guard let data = response.data else {
                    print("Error whiles fetching data: didn't get any data from API")
                    completion("didin't get any data from API",nil)
                    return
                }
                do{
                    let categories = try JSONDecoder().decode(WelcomeBanners.self, from: data)
                    completion(nil,categories)
                }catch{
                    print("Error trying to decode response")
                    print(error.localizedDescription)
                    completion(error.localizedDescription,nil)
                }
            }
        }
    }
}
