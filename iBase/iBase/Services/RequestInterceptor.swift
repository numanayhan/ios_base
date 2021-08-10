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
struct OAuthCredential: AuthenticationCredential {
    let accessToken: String
    let refreshToken: String
    let userID: String
    var expiration: Date

    // Require refresh if within 5 minutes of expiration
    var requiresRefresh: Bool { Date(timeIntervalSinceNow: 60 * 5) > expiration }
}
let credential = OAuthCredential(accessToken: "a0",
                                 refreshToken: "r0",
                                 userID: "u0",
                                 expiration: Date(timeIntervalSinceNow: 60 * 60))


protocol AccessTokenStorage: AnyObject {
    typealias JWT = String
    var accessToken: JWT { get set }
}

final class RequestInterceptor: Alamofire.RequestInterceptor {

    private let storage: AccessTokenStorage

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
               /// The request did not fail due to a 401 Unauthorized response.
               /// Return the original error and don't retry the request.
            
               return completion(.doNotRetryWithError(error))
           }
        print("res",response)
        
//           refreshToken { [weak self] result in
//               guard let self = self else { return }
//
//               switch result {
//               case .success(let token):
//                   self.storage.accessToken = token
//                   /// After updating the token we can safely retry the original request.
//                   completion(.retry)
//               case .failure(let error):
//                   completion(.doNotRetryWithError(error))
//               }
//           }
    }
//    func refreshToken() -> Void {
//        return
//    }
}