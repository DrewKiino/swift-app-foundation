//
//  Stack.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 11/3/19.
//

import Foundation

public struct Stack<T> {
  public private(set) var array = [T]()
  
  public init() {}
  
  public init(array: [T]) {
    self.array = array
  }
  
  public var isEmpty: Bool {
    return array.isEmpty
  }
  
  public var count: Int {
    return array.count
  }
  
  public mutating func push(_ element: T) {
    array.append(element)
  }
  
  @discardableResult
  public mutating func pop() -> T? {
    return array.popLast()
  }
  
  public var top: T? {
    return array.last
  }
  
  public mutating func removeAll() {
    array.removeAll()
  }
}
