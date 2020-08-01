//
//  UserProtocol.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 7/16/19.
//

import Foundation

public protocol UserProtocol {
  var userId: Int { get }
  var email: String? { get }
  var password: String? { get }
  var providerId: Int? { get }
  var providerUserId: Int? { get }
}
