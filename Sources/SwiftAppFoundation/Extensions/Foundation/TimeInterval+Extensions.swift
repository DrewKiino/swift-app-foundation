//
//  TimeInterval+Extensions.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 8/18/19.
//

import Foundation

public extension TimeInterval {
  var date: Date? {
    return Date(timeIntervalSince1970: self / 1000.0)
  }
  /// Rounds the double to decimal places value
  func rounded(toPlaces places: Int) -> TimeInterval {
    let divisor = pow(10.0, TimeInterval(places))
    return (self * divisor).rounded() / divisor
  }
}
