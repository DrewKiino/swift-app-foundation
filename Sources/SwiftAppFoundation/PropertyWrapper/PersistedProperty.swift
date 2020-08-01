//
//  PersistedProperty.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 1/12/20.
//

import Foundation

public protocol PersistedPropertyDelegate: class {
  func initialValue<T: Codable>(for key: String) -> T
  func fetchKey(for propertyKey: String) -> String
}

public class PersistedProperty<T: Codable> {
  private let initialValue: T
  private var _value: T
  public var value: T {
    get { _value }
    set { _value = newValue; save() }
  }

  public weak var delegate: PersistedPropertyDelegate?
  public let propertyKey: String
  
  public init(_ propertyKey: String, delegate: PersistedPropertyDelegate) {
    self.propertyKey = propertyKey
    self.delegate = delegate
    let initialValue: T = delegate.initialValue(for: propertyKey)
    self._value = initialValue
    self.initialValue = initialValue
    self.load()
  }
  
  public init(_ propertyKey: String, _ initialValue: T) {
    self.propertyKey = propertyKey
    self.initialValue = initialValue
    self._value = initialValue
    self.load()
  }
  
  public func modify(_ block: (inout T) -> Void) {
    block(&value)
    self.save()
  }
  
  private func save() {
    let key = delegate?.fetchKey(for: self.propertyKey) ?? self.propertyKey
    if let data = try? JSONEncoder().encode(value) {
      UserDefaults.standard.setValue(data, forKey: key)
      UserDefaults.standard.synchronize()
    }
  }
  
  public func load() {
    let key = delegate?.fetchKey(for: self.propertyKey) ?? self.propertyKey
    if let data = UserDefaults.standard.value(forKey: key) as? Data,
      let value = try? JSONDecoder().decode(T.self, from: data) {
      self.value = value
    } else if let value: T = delegate?.initialValue(for: key) {
      self.value = value
    } else {
      self.value = initialValue
    }
  }
}
