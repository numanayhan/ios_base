//
//  LoginRouter.swift
//  iBase
//
//  Created by Numan Ayhan on 11.08.2021.
//

import Foundation
import Alamofire

enum LoginRouter {
  case params(query: String)
  case refreshToken(refreshToken: String)
  
  
  var baseURL: URL {
    URL(string: "https://api.imgur.com")!
  }
  
  static var authorizationURL = URL(string: "https://api.imgur.com/oauth2/authorize?client_id&response_type=token")!
  
  var path: String {
    switch self {
    case .params:
      return "3/gallery/search/top/all"
    case .refreshToken:
      return "oauth2/token"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .params:
      return .get
    case .refreshToken:
      return .post
    }
  }
  
  var parameters: [String: String] {
    switch self {
    case let .params(query: query):
      return ["q_any": "\(query)"]
    case let .refreshToken(refreshToken: refreshToken):
      return ["refresh_token": refreshToken]
    
    }
  }
}

// MARK: - URLRequestConvertible
extension LoginRouter: URLRequestConvertible {
  func asURLRequest() throws -> URLRequest {
    let url = baseURL.appendingPathComponent(path)
    var request = URLRequest(url: url)
    request.method = method
    request = try URLEncodedFormParameterEncoder(destination: .methodDependent)
      .encode(parameters, into: request)
    return request
  }
}
struct LoginModel: Decodable {
    let data : LoginData
}

struct LoginData : Decodable {
    let accessToken : String
    let user: LoginUser
}

struct LoginUser : Decodable{
    let userId : String
    let firstName: String
    let lastName: String
    let salesOrganizations: [String]
}

struct LoginPost:Codable {
    let userName : String
    let password : String
    let loginInfo : LoginInfo
}
struct LoginInfo : Codable {
    let webVersion : String
}
