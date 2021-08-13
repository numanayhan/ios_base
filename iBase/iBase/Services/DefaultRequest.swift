//
//  BaseRequest.swift
//  iBase
//
//  Created by Numan Ayhan on 10.08.2021.
//

import Foundation
import Alamofire

enum RequestError: Error {
    case incalidUrl
    case invalidData
    case tokenError
    case networkError(String?)
    case domainError(String?,String?)
    case unknownError(String?)
    case authFailed
    case connectivity
    case badURL
}
class DefaultRequest {
    func  genericRequest<T: Codable>( url:URL,expecting:T.Type ,attendences:String , completion: @escaping(Any) ->Void)
    {
        print(url)
         
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            
            let loginUserInfo = LoginPost( userName : "onur.iriz",password: "Tirci59!",loginInfo:  LoginInfo(webVersion: "2.0.12"))
            let jsonBody = try JSONEncoder().encode(loginUserInfo)
            
            request.httpBody = jsonBody
            
            AF.request(request).responseJSON { (response) in
                
                print(response.result)
                
            }
            
        }catch let err  {
            print("jsonBody Error: ",err)
        }
    }
}
 
