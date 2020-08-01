//
//  String+Extensions.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 6/30/19.
//

import Foundation
import UIKit

public extension String {
  var iso8601Date: Date? {
    return Formatter.iso8601.date(from: self)
  }
  
  func sizeThatFits(_ targetSize: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), font: UIFont) -> CGSize {
    let label = UILabel()
    label.font = font
    label.text = self
    let size = label.sizeThatFits(targetSize)
    return CGSize(
      width: max(size.width, targetSize.width),
      height: max(size.height, targetSize.height)
    )
  }

  func matches(_ regex: String) -> [String] {
    guard let regex = try? NSRegularExpression(
      pattern: regex,
      options: .caseInsensitive
    ) else { return [] }
    return regex.matches(
      in: self,
      options: [],
      range: NSMakeRange(0, self.count)
    ).map {
      String(self[Range($0.range, in: self)!])
    }
  }
  
  func toIntOrNull() -> Int? { Int(self) }
}

public extension Optional where Wrapped == String {
  var isNilOrEmpty: Bool {
    return (self ?? "").isEmpty
  }
}

public func randomUUIDString() -> String { UUID().uuidString }
