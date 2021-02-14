//
//  AddToCartManager.swift
//  JaddaButcher
//
//  Created by Elattar on 1/17/21.
//  Copyright © 2021 Elattar. All rights reserved.
//

import Foundation
import Alamofire

class APIManagerAddToCart{
    
    static func addToCartHashi (productId: String,  quantity: String,price: String, sessionCode: String,note: String ,completion: @escaping (_ error: String?, _ succss: WelcomeAddToCart?) -> ()){
        
        let url = URLs.addToCart
        
        let parameter: [String: Any] = [
            
            "product_id": productId,
            "size": "1",
            "quantity": quantity,
            "price": price,
            "session_code": sessionCode,
            "notes":note
        ]
        
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.httpBody, headers: nil)
            .responseJSON { (response) in
                switch response.result{
                    
                case .failure(let error):
                    // print("Error while fetching data: \(error.localizedDescription)")
                    completion("Error while fetching data: \(error.localizedDescription)", nil)
                case .success(_):
                    //  print(response.result.value)
                    guard let data = response.data else {
                        //  print("Error whiles fetching data: didn't get any data from API")
                        completion("Error whiles fetching data: didn't get any data from API",nil)
                        return
                    }
                    do{
                        let token = try JSONDecoder().decode(WelcomeAddToCart.self, from: data)
                        if let api_token = token.sessionCode{
                            print("SessionCodeee: \(api_token)")
                            Helper.saveToken(token: api_token)
                            completion(nil,token)
                        }else{
                            print("Not Found Token")
                        }
                    }catch{
                        // print("Error trying to decode response, \(error.localizedDescription)")
                        completion("Error trying to decode response, \(error.localizedDescription)",nil)
                    }
                    
                }
        }
        
    }
    
    
    static func addToCartCharity (productId: String,  quantity: String,price: String, sessionCode: String,note: String ,completion: @escaping (_ error: String?, _ succss: WelcomeAddToCart?) -> ()){
        
        let url = URLs.addToCart
        
        let parameter: [String: Any] = [
            
            "product_id": productId,
            "size": "1",
            "quantity": quantity,
            "price": price,
            "session_code": sessionCode,
            "notes":note
        ]
        
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.httpBody, headers: nil)
            .responseJSON { (response) in
                switch response.result{
                    
                case .failure(let error):
                    // print("Error while fetching data: \(error.localizedDescription)")
                    completion("Error while fetching data: \(error.localizedDescription)", nil)
                case .success(_):
                    //  print(response.result.value)
                    guard let data = response.data else {
                        //  print("Error whiles fetching data: didn't get any data from API")
                        completion("Error whiles fetching data: didn't get any data from API",nil)
                        return
                    }
                    do{
                        let token = try JSONDecoder().decode(WelcomeAddToCart.self, from: data)
                        if let api_token = token.sessionCode{
                            print("SessionCodeee: \(api_token)")
                            Helper.saveToken(token: api_token)
                            completion(nil,token)
                        }else{
                            print("Not Found Token")
                        }
                    }catch{
                        // print("Error trying to decode response, \(error.localizedDescription)")
                        completion("Error trying to decode response, \(error.localizedDescription)",nil)
                    }
                    
                }
        }
        
    }
    
    static func addToCart (productId: String,size: String, quantity: String,price: String, sessionCode: String,note: String,kersh: String,soup_kilos: String,minced_kilos: String,type: String,pay_method: String,minced: String,category_id: String,head: String,meat_package: String,parts: String ,completion: @escaping (_ error: String?, _ succss: WelcomeAddToCart?) -> ()){
        
        let url = URLs.addToCart
        
        let parameter: [String: Any] = [
            "product_id": productId,
            "size": size,
            "quantity": quantity,
            "price": price,
            "session_code": sessionCode,
            "notes":note,
            "kersh": kersh,
            "soup_kilos": soup_kilos,
            "minced_kilos": minced_kilos,
            "type": type,
            "pay_method": pay_method,
            "minced": minced,
            "category_id": category_id,
            "head": head,
            "meat_package": meat_package,
            "parts": parts
        ]
        
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.httpBody, headers: nil)
            .responseJSON { (response) in
                switch response.result{
                    
                case .failure(let error):
                    // print("Error while fetching data: \(error.localizedDescription)")
                    completion("Error while fetching data: \(error.localizedDescription)", nil)
                case .success(_):
                    //  print(response.result.value)
                    guard let data = response.data else {
                        //  print("Error whiles fetching data: didn't get any data from API")
                        completion("Error whiles fetching data: didn't get any data from API",nil)
                        return
                    }
                    do{
                        let token = try JSONDecoder().decode(WelcomeAddToCart.self, from: data)
                        if let api_token = token.sessionCode{
                            print("SessionCodeee: \(api_token)")
                            Helper.saveToken(token: api_token)
                            completion(nil,token)
                        }else{
                            print("Not Found Token")
                        }
                    }catch{
                        // print("Error trying to decode response, \(error.localizedDescription)")
                        completion("Error trying to decode response, \(error.localizedDescription)",nil)
                    }
                    
                }
        }
        
    }
    
    
    static func updateQuantity (sessionCode: String, cardId: String,quantity: String ,completion: @escaping (_ error: String?, _ succss: UpdateQuantityInCart?) -> ()){
           
           let url = URLs.updateQuantityInCart
           
           let parameter: [String: Any] = [
               "session_code": sessionCode,
               "cart_id": cardId,
               "quantity": quantity
           ]
           
           Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.httpBody, headers: nil)
               .validate(statusCode: 200..<300)
               .responseJSON { (response) in
                   switch response.result{
                       
                   case .failure(let error):
                       print("Error while fetching data: \(error.localizedDescription)")
                       completion(error.localizedDescription, nil)
                   case .success(_):
                       //  print(response.result.value)
                       guard let data = response.data else {
                           print("Error whiles fetching data: didn't get any data from API")
                           completion("didin't get any data from API",nil)
                           return
                       }
                       do{
                           let token = try JSONDecoder().decode(UpdateQuantityInCart.self, from: data)
                           completion(nil,token)
                       }catch{
                           print("Error trying to decode response")
                           print(error)
                           completion(error.localizedDescription,nil)
                       }
                       
                   }
           }
           
       }
    
    
    static func deleteCart (sessionCode: String, cardId: String ,completion: @escaping (_ error: String?, _ succss: UpdateQuantityInCart?) -> ()){
        
        let url = URLs.deleteCart
        
        let parameter: [String: Any] = [
            "session_code": sessionCode,
            "cart_id": cardId,
        ]
        
        Alamofire.request(url, method: .post, parameters: parameter, encoding: URLEncoding.httpBody, headers: nil)
            .responseJSON { (response) in
                switch response.result{
                    
                case .failure(let error):
                    print("Error while fetching data: \(error.localizedDescription)")
                    completion(error.localizedDescription, nil)
                case .success(_):
                     // print(response.result.value)
                    guard let data = response.data else {
                        print("Error whiles fetching data: didn't get any data from API")
                        completion("didin't get any data from API",nil)
                        return
                    }
                    do{
                        let token = try JSONDecoder().decode(UpdateQuantityInCart.self, from: data)
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
