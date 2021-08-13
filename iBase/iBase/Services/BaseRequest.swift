//
//  BaseRequest.swift
//  iBase
//
//  Created by Numan Ayhan on 12.08.2021.
//

import Foundation
import Alamofire
import PromiseKit
class Config {
    static let backendUrl = ""
}
struct LoginResponse {
    var data: DataClass?
    var success: Bool?
    var errorCode, message, url: String?
}

struct DataClass: Codable {
    var accessToken, refreshToken: String?
    var accessTokenExpires, refreshTokenExpires: Int?
}

struct BaseResponse<T:Decodable> : Decodable{
    var success: Bool?
    var errorCode, message, url: String?
    var response:T
    
}
let accessTokenAdapter = AccessTokenAdapter()
typealias AdapterResult = Swift.Result<URLRequest, Error>
public class AccessTokenAdapter: Alamofire.RequestAdapter {
    private var accessToken: String = ""
    private var prefix: String = ""
    
    func setAccessToken(accessToken: String) {
        self.accessToken = accessToken
    }
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (AdapterResult) -> Void)  {
        var urlRequest = urlRequest
        
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(Config.backendUrl) {
            if accessToken != "" {
                urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
                completion(.success(urlRequest))
            }else{
                completion(.failure(RequestError.tokenError))
            }
        }
         
    }
}
class ServiceManager{
    func saveToken()   {
        
    }
}
class NetworkManager {
    static let api = NetworkManager()
    private init(){}
    func postRequest<T:Decodable>() -> Promise<BaseResponse<T>>{
        let credential = URLCredential(user :"", password: "password", persistence: .forSession)

        return Promise<BaseResponse<T>>{ resolve in
            AF.request("",method: .post).authenticate(with: credential)
            
        }
    }
    
    
}
