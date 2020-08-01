//
//  ConditionalError.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 1/26/20.
//

import Foundation

public struct ConditionalError: LocalizedError {
  private let message: String
  public init(_ message: String) {
    self.message = message
  }
  public var errorDescription: String? { "ConditionalError" }
  public var failureReason: String? { message }
}
