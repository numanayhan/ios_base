//
//  TokenHandler.swift
//  iBase
//
//  Created by Numan Ayhan on 11.08.2021.
//

import Foundation
struct AuthenticationData: Decodable {
  let accessToken: String
  let refreshToken: String
  let expiresIn: Double
  
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case refreshToken = "refresh_token"
    case expiresIn = "expires_in"
  }
}
private struct Tokens {
  static let accessToken = "accessToken"
  static let refreshToken = "refreshToken"
}

protocol TokenHandler {
  var accessToken: String? { get }
  var refreshToken: String? { get }
  func handleTokens(from callbackUrl: URL)
  func saveTokens(accessToken: String, refreshToken: String)
}
// MARK: - Token Extraction
extension TokenHandler {
  func handleTokens(from callbackUrl: URL) {
    let tokens = extractTokens(from: callbackUrl.absoluteString)
    guard
      let accessToken = tokens.accessToken,
      let refreshToken = tokens.refreshToken
      else {
        return
    }
    saveTokens(accessToken: accessToken, refreshToken: refreshToken)
  }
  
  private func extractTokens(from callbackUrl: String)
    -> (accessToken: String?, refreshToken: String?) {
      let accessToken = callbackUrl.firstMatchingValue(withGroupedPattern: "access_token=((\\w)*)")
      let refreshToken = callbackUrl.firstMatchingValue(withGroupedPattern: "refresh_token=((\\w)*)")
      return (accessToken, refreshToken)
  }
}
// MARK: - Token Storage
extension TokenHandler {
  var accessToken: String? {
    KeychainStore.default.value(for: Tokens.accessToken)
  }
  
  var refreshToken: String? {
    KeychainStore.default.value(for: Tokens.refreshToken)
  }
  
  func saveTokens(accessToken: String, refreshToken: String) {
    KeychainStore.default.set(accessToken, for: Tokens.accessToken)
    KeychainStore.default.set(refreshToken, for: Tokens.refreshToken)
  }
}

class KeychainStore {
  static let `default` = KeychainStore()
  private let service = "default"
  
  @discardableResult
  func set(_ value: String, for userAccount: String) -> Bool {
    guard let encodedPassword = value.data(using: .utf8) else {
      return false
    }
    var query = [String(kSecAttrService): service,
                 String(kSecClass): kSecClassGenericPassword,
                 String(kSecAttrAccount): userAccount] as [String : Any]
    var status = SecItemCopyMatching(query as CFDictionary, nil)
    switch status {
    case errSecSuccess:
      var attributesToUpdate: [String: Any] = [:]
      attributesToUpdate[String(kSecValueData)] = encodedPassword
      status = SecItemUpdate(query as CFDictionary,
                             attributesToUpdate as CFDictionary)
      return status == errSecSuccess
    case errSecItemNotFound:
      query[String(kSecValueData)] = encodedPassword
      status = SecItemAdd(query as CFDictionary, nil)
      return status == errSecSuccess
    default:
      return false
    }
  }
  
  func value(for userAccount: String) -> String? {
    let query = [String(kSecAttrService): service,
                 String(kSecClass): kSecClassGenericPassword,
                 String(kSecAttrAccount): userAccount,
                 String(kSecMatchLimit): kSecMatchLimitOne,
                 String(kSecReturnAttributes): kCFBooleanTrue as Any,
                 String(kSecReturnData): kCFBooleanTrue as Any] as [String : Any]
    var queryResult: AnyObject?
    let status = withUnsafeMutablePointer(to: &queryResult) {
      SecItemCopyMatching(query as CFDictionary, $0)
    }
    switch status {
    case errSecSuccess:
      guard
        let queriedItem = queryResult as? [String: Any],
        let passwordData = queriedItem[String(kSecValueData)] as? Data,
        let password = String(data: passwordData, encoding: .utf8)
        else {
          return nil
      }
      return password
    default:
      return nil
    }
  }
}
extension String {
  func firstMatchingValue(withGroupedPattern pattern: String) -> String? {
    guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
    let match = regex.firstMatch(in: self, options: [], range: range)
    if let matchedRange = match?.range(at: 1),
      matchedRange.location != NSNotFound,
      let range = Range(matchedRange, in: self) {
      return String(self[range])
    }
    return nil
  }
  
  var range: NSRange {
    NSRange(self.startIndex ..< self.endIndex, in: self)
  }
}
