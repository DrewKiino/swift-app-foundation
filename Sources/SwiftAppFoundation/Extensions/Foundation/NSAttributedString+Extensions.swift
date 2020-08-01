//
//  NSAttributedString+Extensions.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 3/27/19.
//

import UIKit

extension TextAttributes {
  public static func styled(
    _ color: UIColor?,
    font: UIFont?,
    kern: NSNumber = 0.0,
    lineSpacing: CGFloat = 0.0,
    minimumLineHeight: CGFloat = 0.0,
    maximumLineHeight: CGFloat = 0.0,
    lineHeightMultiple: CGFloat = 1.0,
    alignment: NSTextAlignment? = .left,
    underline: Bool = false
  ) -> TextAttributes {
    let style = NSMutableParagraphStyle()
    style.lineBreakMode = .byWordWrapping
    style.lineSpacing = lineSpacing
    style.minimumLineHeight = minimumLineHeight
    style.maximumLineHeight = maximumLineHeight
    style.lineHeightMultiple = lineHeightMultiple
    if let alignment = alignment {
      style.alignment = alignment
    }
    var dict: Dictionary = [
      .foregroundColor: color,
      .font: font,
      .kern: kern,
      .paragraphStyle: style
    ].compactMapValues { $0 }
    if underline {
      dict[.underlineStyle ] = NSUnderlineStyle.single.rawValue
    }
    return dict
  }
}
