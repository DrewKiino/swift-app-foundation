//
//  Collection+Extensions.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 11/3/19.
//

import Foundation

extension Collection {
  public var isNotEmpty: Bool { return !isEmpty }
}

extension Collection where Element: Hashable {
  public func sortedMap(
    first: ((Element) -> Bool),
    next: ((Element) -> Element?)
  ) -> [Element] {
    var items: [Element] = []
    if let first = self.first(where: first) {
      var curr: Element? = first
      while curr != nil {
        items.append(curr!)
        curr = next(curr!)
      }
    }
    return items
  }
}
