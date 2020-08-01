//
//  ShadowViewModel.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 7/21/19.
//

import UIKit

// MARK: - Shadow View Model

public protocol ShadowViewModelProtocol {
  var viewModel: ShadowViewModel { get }
}

public struct ShadowViewModel {
  public let color: UIColor
  public let offset: CGSize
  public let radius: CGFloat
  public let opacity: CGFloat
  
  public init(color: UIColor, offset: CGSize, radius: CGFloat, opacity: CGFloat) {
    self.color = color
    self.offset = offset
    self.radius = radius
    self.opacity = opacity
  }
}

extension ShadowViewModel: ShadowViewModelProtocol {
  public var viewModel: ShadowViewModel {
    return self
  }
}

extension UIView {
  public func addShadow(_ viewModel: ShadowViewModelProtocol) {
    let viewModel = viewModel.viewModel
    layer.shadowColor = viewModel.color.cgColor
    layer.shadowOffset = viewModel.offset
    layer.shadowRadius = viewModel.radius
    layer.shadowOpacity = Float(viewModel.opacity)
  }
}
