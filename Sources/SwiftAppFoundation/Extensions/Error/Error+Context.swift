//
//  Error+Context.swift
//  App
//
//  Created by Andrew Aquino on 4/9/19.
//

import Foundation

public protocol Alertable where Self: Error {
  var localizedTitle: String { get }
//  var localizedFormalDescription: String? { get }
  var localizedDescription: String { get }
}
