//
//  AppBuildSource.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 2/19/20.
//

import Foundation

public enum AppBuildSource {
  case simulator
  case testFlight
  case appStore
  
  public static func source() -> AppBuildSource {
    if let path = Bundle.main.appStoreReceiptURL?.path {
      if path.contains("CoreSimulator") {
        return .simulator
      } else if path.contains("sandboxReceipt") {
        return .testFlight
      }
    }
    return .appStore
  }
}
