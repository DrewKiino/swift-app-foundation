//
//  Encodable+Extensions.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 7/23/19.
//

import Foundation

extension Encodable {
  public func toJSON() throws -> [String: Any]? {
    let encoder = JSONEncoder()
    let data = try encoder.encode(self)
    let object = try JSONSerialization.jsonObject(with: data)
    guard let json = object as? [String: Any] else {
      let context = DecodingError.Context(codingPath: [], debugDescription: "Deserialized object is not a dictionary")
      throw DecodingError.typeMismatch(type(of: object), context)
    }
    return json
  }
}

