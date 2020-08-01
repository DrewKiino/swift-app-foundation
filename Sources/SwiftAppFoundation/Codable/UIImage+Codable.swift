//
//  UIImage+Codable.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 7/28/19.
//

import Foundation
import UIKit

public struct CodableImage: Codable {
  private enum CodingKeys: CodingKey {
    case image
  }
  
  public let image: UIImage?
  
  public init?(_ image: UIImage?) {
    guard let image = image else { return nil }
    self.image = image
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    guard let data = self.image?.pngData() else { return }
    let stringData = String(decoding: data, as: UTF8.self)
    try container.encode(stringData, forKey: .image)
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let stringData = try container.decode(String.self, forKey: .image)
    self.image = UIImage(data: Data(stringData.utf8))
  }
}
