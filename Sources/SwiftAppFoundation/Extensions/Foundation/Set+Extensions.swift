//
//  Set+Extensions.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 11/11/19.
//

import Foundation

extension Set {
  public func removing(_ element: Element) -> Set<Element> {
    var set = self
    set.remove(element)
    return set
  }
}

extension Set where Element: Hashable {
  public func firstMap<T>(_ transform: (Element) -> T?) -> T? {
    for el in self { if let val = transform(el) { return val } }
    return nil
  }
}

extension Array where Element == Set<Int> {
  public func elementSetsContain(_ element: Int) -> Bool {
    return first { $0.contains(element) } != nil
  }
}

extension Array where Element == Set<String> {
  public func elementSetsContain(_ element: String) -> Bool {
    return first { $0.contains(element) } != nil
  }
}
