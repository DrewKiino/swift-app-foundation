//
//  Array+Extensions.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 11/13/19.
//

import Foundation

extension Array {
  public func firstMap<T>(_ transform: (Element) -> T?) -> T? {
    for el in self { if let val = transform(el) { return val } }
    return nil
  }
  
  public func indexed<T: Hashable>(by closure: @escaping (Element) -> T) -> [T: Element] {
    return Dictionary<T, Element>(uniqueKeysWithValues: map { (closure($0), $0) })
  }
  
  public func merging<T: Hashable>(_ target: Array<Element>, sourceIndex: @escaping (Element) -> T, targetIndex: @escaping (Element) -> T) -> [Element] {
    let indexedSource = self.indexed(by: sourceIndex)
    let indexedTarget = target.indexed(by: targetIndex)
    return Array(indexedSource.merging(indexedTarget, uniquingKeysWith: { s, t in t }).values)
  }
  
  public mutating func merge<T: Hashable>(_ target: Array<Element>, sourceIndex: @escaping (Element) -> T, targetIndex: @escaping (Element) -> T) {
    let indexedSource = self.indexed(by: sourceIndex)
    let indexedTarget = target.indexed(by: targetIndex)
    self = Array(indexedSource.merging(indexedTarget, uniquingKeysWith: { s, t in t }).values)
  }

  public mutating func append(_ newElement: Element, if closure: @escaping (Element) -> Bool) {
    if contains(where: closure) {
      append(newElement)
    }
  }
  
  public func firstIndex(_ closure: (Element) -> Bool) -> Int? {
    if let (index, _) = self.enumerated().first(where: { closure($1) }) {
      return index
    }
    return nil
  }
}

extension Array where Element: Equatable {
  @discardableResult
  public mutating func remove(_ element: Element) -> Element? {
    if let index = firstIndex({ $0 == element }) {
      return remove(at: index)
    }
    return nil
  }
}
