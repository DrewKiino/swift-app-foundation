//
//  Formatter+Extensions.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 8/14/19.
//

import Foundation

extension Formatter {
  public static let iso8601: ISO8601DateFormatter = {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [
      .withFullDate,
      .withTime,
      .withDashSeparatorInDate,
      .withColonSeparatorInTime
    ]
    return formatter
  }()
}
