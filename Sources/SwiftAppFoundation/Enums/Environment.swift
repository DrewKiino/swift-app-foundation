//
//  Environment.swift
//  Fable
//
//  Created by Andrew Aquino on 12/13/19.
//

import Foundation

public enum Environment: String, Codable, ExpressibleByStringLiteral {
  public typealias StringLiteralType = String
  
  case local
  case stage
  case prod
  
  public init(stringLiteral value: String) {
    switch value {
    case "local": self = .local
    case "prod": self = .prod
    default: self = .stage
    }
  }
}
