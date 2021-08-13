//
//  RequestInterceptor.swift
//  iBase
//
//  Created by Numan Ayhan on 22.07.2021.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
let baseURL = "https://dev-api.netcrm.dev"
struct  AuthCredential: AuthenticationCredential {
    let accessToken: String
    let refreshToken: String
    let userID: String
    var expiration: Date
    // Require refresh if within 5 minutes of expiration
    var requiresRefresh: Bool { Date(timeIntervalSinceNow: 60 * 5) > expiration }
}
let credential =  AuthCredential(accessToken: "a0",
                                 refreshToken: "r0",
                                 userID: "u0",
                                 expiration: Date(timeIntervalSinceNow: 60 * 60))


protocol AccessTokenStorage: AnyObject {
    typealias JWT = String
    var accessToken: JWT { get set }
}

final class RequestInterceptor: Alamofire.RequestInterceptor,Authenticator {
    func handleTokens(from callbackUrl: URL) {
        print(callbackUrl.absoluteString)
    }
    
    var retryLimit = 3
    let storage: AccessTokenStorage
    var lastProceededResponse: HTTPURLResponse?
   
    init(storage: AccessTokenStorage) {
        self.storage = storage
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix(baseURL) == true else {
            /// If the request does not require authentication, we can directly return it as unmodified.
            return completion(.success(urlRequest))
        }
        var urlRequest = urlRequest

        /// Set the Authorization header value using the access token.
        urlRequest.setValue("Bearer " + storage.accessToken, forHTTPHeaderField: "Authorization")

        completion(.success(urlRequest))
    }
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
           guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
                
               return completion(.doNotRetryWithError(error))
           }
        guard
          lastProceededResponse != request.response,
          request.retryCount < retryLimit,
          let statusCode = request.response?.statusCode,
          statusCode.isAuthenticationErrorCode()
          else {
            return completion(.doNotRetry)
        }
        lastProceededResponse = request.response
        refreshToken { isSuccess in
          isSuccess ? completion(.retry) : completion(.doNotRetry)
        }
         
    }
}
