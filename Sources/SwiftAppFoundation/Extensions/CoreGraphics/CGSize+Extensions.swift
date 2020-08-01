//
//  CGSize+Extensions.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 11/14/19.
//

import UIKit

extension CGSize {
  public func inset(by insets: UIEdgeInsets) -> CGSize {
    let rect = CGRect(origin: .zero, size: self)
    return rect.inset(by: insets).size
  }
  
  public func reverseInset(by insets: UIEdgeInsets) -> CGSize {
    let rect = CGRect(origin: .zero, size: self)
    return rect.inset(by: UIEdgeInsets(top: -insets.top, left: -insets.left, bottom: -insets.bottom, right: -insets.right)).size
  }
}

