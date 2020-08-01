//
//  Creatable+Modifiable.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 4/21/19.
//

import Foundation
import UIKit

public protocol Creatable {
  init()
}

extension Creatable {
  public static func create(_ creationBlock: (Self) -> Void) -> Self {
    let object = self.init()
    creationBlock(object)
    return object
  }
  
  public func also(_ modify: (Self) -> Void) -> Self {
    modify(self)
    return self
  }
}


extension UIView: Creatable {}
extension UIBarButtonItem: Creatable {}
