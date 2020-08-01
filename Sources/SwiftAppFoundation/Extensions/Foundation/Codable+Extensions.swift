//
//  Codable+Extensions.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 11/26/19.
//

import Foundation

extension Encodable {
  public func merging<T>(target: T) -> T? where T: Codable {
    let jsonEncoder = JSONEncoder()
    do {
      let sData = try jsonEncoder.encode(self)
      let tData = try jsonEncoder.encode(target)
      if
        let sJSON = try JSONSerialization.jsonObject(with: sData, options: .allowFragments) as? [String: Any],
        let tJSON = try JSONSerialization.jsonObject(with: tData, options: .allowFragments) as? [String: Any]
      {
        let json = sJSON.merging(tJSON, uniquingKeysWith: { s, t in t })
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        let object = try JSONDecoder().decode(T.self, from: data)
        return object
      }
    } catch let error {
      print(error)
    }
    return nil
  }
  
  public var prettyJSONString: String {
    {
      do {
        let encoded = try JSONEncoder().encode(self)
        let json = try JSONSerialization.jsonObject(with: encoded, options: .allowFragments)
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        return String(data: data, encoding: .utf8)
      } catch let error {
        print(error)
        return error.localizedDescription
      }
    }() ?? String(describing: self)
  }
}

