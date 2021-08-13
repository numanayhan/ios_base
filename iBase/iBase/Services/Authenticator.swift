//
//  Authenticator.swift
//  iBase
//
//  Created by Numan Ayhan on 11.08.2021.
//

import Foundation
import Alamofire

protocol Authenticator: class, TokenHandler {
  func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void)
}

// MARK: - Token Refresher
extension Authenticator {
  func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
    guard let refreshToken = refreshToken else {
      return completion(false)
    }
    AF.request(LoginRouter.refreshToken(refreshToken: refreshToken))
      .validate()
      .responseDecodable(of: AuthenticationData.self) { [weak self] response in
        guard let self = self, let response = response.value else {
            return completion(false)
        }
        self.saveTokens(accessToken: response.accessToken, refreshToken: response.refreshToken)
        completion(true)
    }
  }
}

// MARK: - Error Code Checker
extension Int {
  func isAuthenticationErrorCode() -> Bool {
    [401, 403].contains(self)
  }
}
