//
//  Date+Extensions.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 6/15/19.
//

import Foundation

extension Date {
  public var iso8601String: String {
    return Formatter.iso8601.string(from: self)
  }

  public static var now: Date {
    return Date()
  }
  
  public init?(_ dateString: String?) {
    guard
      let dateString = dateString,
      let date = Formatter.iso8601.date(from: dateString)
      else { return nil }
    self = date
  }
}
