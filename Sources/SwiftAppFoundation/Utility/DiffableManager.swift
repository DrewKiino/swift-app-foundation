//
//  DiffableManager.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 12/7/19.
//

import Foundation

public struct Diffable<T: Hashable>: CustomStringConvertible {
  public let append: Set<T>, remove: Set<T>, update: Set<T>
  
  public init(
    append: Set<T> = [],
    remove: Set<T> = [],
    update: Set<T> = []
  ) {
    self.append = append
    self.remove = remove
    self.update = update
  }
  
  public var description: String {
    return "append \(append)\nremove \(remove)\nupdate \(update)"
  }
}

public class DiffableManager<T: Hashable> {
  
  public init() {
    
  }
  
  public func checkDiffable(source: [T], target: [T]) -> Diffable<T> {
    let s = Set(source)
    let t = Set(target)
    let append = s.subtracting(t)
    let remove = t.subtracting(s)
    let update = s.union(t)
    return Diffable(append: append, remove: remove, update: update)
  }
}
