//
//  PersistentProperty.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 1/8/20.
//

import Foundation

public protocol PersistentPropertyDelegate: class {
  func initialValue<T>(for propertyKey: String) -> T?
  func fetchKey(for propertyKey: String) -> String?
}

@propertyWrapper
public struct PersistentProperty<T: Codable> {
  private let initialValue: T
  private var value: T
  public var wrappedValue: T {
    get { value }
    set { value = newValue }
  }
  
  public weak var delegate: PersistentPropertyDelegate? {
    didSet {
      load()
    }
  }
    
  public var projectedValue: Self {
    get { self }
    set { self = newValue }
  }
  
  public let propertyKey: String
  
  public init(_ propertyKey: String, _ initialValue: T) {
    self.propertyKey = propertyKey
    self.initialValue = initialValue
    self.value = initialValue
    self.load()
  }
  
  public mutating func modify(_ block: (inout T) -> Void) {
    block(&wrappedValue)
    save()
  }
  
  public func save() {
    if envBool("disable_local_persistence") == true { return }
    guard let delegate = self.delegate else { return }
    guard let key = delegate.fetchKey(for: self.propertyKey) else { return }
    if let data = try? JSONEncoder().encode(value) {
      UserDefaults.standard.setValue(data, forKey: key)
      UserDefaults.standard.synchronize()
    }
  }
  
  public mutating func load() {
    if envBool("disable_local_persistence") == true { return }
    guard let delegate = self.delegate else { return }
    guard let key = delegate.fetchKey(for: self.propertyKey) else { return }
    if let data = UserDefaults.standard.value(forKey: key) as? Data,
      let value = try? JSONDecoder().decode(T.self, from: data) {
      self.value = value
    } else if let value: T = delegate.initialValue(for: key) {
      self.value = value
    } else {
      self.value = initialValue
    }
  }
}
