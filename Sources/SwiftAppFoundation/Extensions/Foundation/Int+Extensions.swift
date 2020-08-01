//
//  Int+Extensions.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 8/18/19.
//

import Foundation

public extension Int {
  var date: Date? {
    return Date(timeIntervalSince1970: Double(self))
  }
  
  func toString() -> String { "\(self)" }
}

public func randomInt() -> Int { Int.random(in: 0...Int.max) }
