//
//  Optional+Extensions.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 12/26/19.
//

import Foundation

extension Optional where Wrapped == Int {
  public var isNil: Bool {
    return self == nil 
  }
}
