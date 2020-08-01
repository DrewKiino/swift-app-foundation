//
//  NSMutableAttributedString+Extensions.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 11/19/19.
//

import Foundation

extension NSMutableAttributedString {
  public func replacingSubstrings(matching replacements: [(string: String, withAttributes: [NSMutableAttributedString.Key: Any])]) -> NSMutableAttributedString {
    var newStartString = string
    let rAttrStrings = replacements.map { string, attributes -> NSMutableAttributedString in
      newStartString = self.string.replacingOccurrences(of: string, with: "")
      return NSMutableAttributedString(string: string, attributes: attributes)
    }
    let startAttrString = NSMutableAttributedString(string: newStartString, attributes: self.attributes)
    rAttrStrings.forEach { startAttrString.append($0) }
    return startAttrString
  }
  
  public func replacingAttributes(_ attributes: TextAttributes) -> Self {
    guard let range = NSRange(self.string) else { return self }
    setAttributes(attributes, range: range)
    return self
  }
}
