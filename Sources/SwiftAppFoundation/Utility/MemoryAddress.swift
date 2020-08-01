//
//  MemoryAddress.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 1/15/20.
//

import Foundation

public class MemoryAddress<T: AnyObject> {
  private let object: T
  
  public init(_ object: T) {
    self.object = object
  }
//  public func address(o: UnsafePointer<Void>) -> Int {
//    return unsafeBitCast(o, Int.self)
//  }
//
  public func addressHeap() -> Int {
    return unsafeBitCast(object, to: Int.self)
  }
}
