//
//  ResponseError.swift
//  iBase
//
//  Created by Numan Ayhan on 11.08.2021.
//

import Foundation  

enum ResponseError: Error {
  case connection
  case authentication(message: String)
  case server(message: String)
}
extension ResponseError {
  var localizedDescription: String {
    switch self {
    case let .authentication(message):
      return message
    case let .server(message: message):
      return message
    case .connection:
      return "Check your internet connection"
    }
  }
  
  var isAuthenticationError: Bool {
    if case .authentication = self {
      return true
    }
    return false
  }
}
