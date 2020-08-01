//
//  ObjectCollection.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 8/20/19.
//

import Foundation

public struct ObjectCollection<T: Codable>: Codable {
  public let items: [T]
  
  public init(items: [T]? = nil) {
    self.items = items ?? []
  }
}
