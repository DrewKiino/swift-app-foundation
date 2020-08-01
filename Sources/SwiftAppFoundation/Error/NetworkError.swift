//
//  NetworkError.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 1/8/20.
//

import Foundation

public enum NetworkError: LocalizedError, CustomStringConvertible {
  case network(Error?, String?)
  case noData
  case parameterParsingFailed(Error)
  
  public var localizedTitle: String {
    return "Network Error"
  }
  
  public var description: String { localizedDescription }
  public var errorDescription: String? { localizedDescription }

  public var localizedDescription: String {
    switch self {
    case let .network(error, description):
      let message = [error?.localizedDescription, description].compactMap { $0 }.joined(separator: " ")
      if message.isEmpty {
        return "No error description given."
      }
      return message
    case .noData: return "No Data"
    case let .parameterParsingFailed(error):
      return error.localizedDescription
    }
  }
}
