//
//  BorderViewModel.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 7/21/19.
//

import UIKit

public protocol BorderViewModelProtocol {
  var viewModel: BorderViewModel { get }
}

public struct BorderViewModel {
  public enum Edge {
    case all
    case top
    case bottom
    case left
    case right
  }
  
  public let color: UIColor
  public let width: CGFloat

  public init(color: UIColor, width: CGFloat) {
    self.color = color
    self.width = width
  }
}

extension BorderViewModel: BorderViewModelProtocol {
  public var viewModel: BorderViewModel {
    return self
  }
}

extension UIView {
  public func addBorder(_ edge: BorderViewModel.Edge, viewModel: BorderViewModelProtocol) {
    let viewModel = viewModel.viewModel
    if case .all = edge {
      layer.borderColor = viewModel.color.cgColor
      layer.borderWidth = viewModel.width
    } else {
      DispatchQueue.main.async {
        self.addBorder(edge, color: viewModel.color, width: viewModel.width)
      }
    }
  }

  private func addBorder(_ edge: BorderViewModel.Edge, color: UIColor, width: CGFloat) {
    let border = UIView()
    border.layer.borderColor = color.cgColor
    border.layer.borderWidth = width
    addSubview(border)
    if edge == .bottom || edge == .top {
      border.leadingAnchor.constraint(equalTo: leadingAnchor).activate()
      border.trailingAnchor.constraint(equalTo: trailingAnchor).activate()
      border.widthAnchor.constraint(equalToConstant: width).activate()
      if edge == .bottom {
        border.bottomAnchor.constraint(equalTo: bottomAnchor).activate()
      } else if edge == .top {
        border.topAnchor.constraint(equalTo: topAnchor).activate()
      }
    } else if edge == .left || edge == .right {
        border.topAnchor.constraint(equalTo: topAnchor).activate()
        border.bottomAnchor.constraint(equalTo: bottomAnchor).activate()
        border.widthAnchor.constraint(equalToConstant: width).activate()
      if edge == .left {
        border.leadingAnchor.constraint(equalTo: leadingAnchor).activate()
      } else if edge == .right {
        border.trailingAnchor.constraint(equalTo: trailingAnchor).activate()
      }
    }
  }
}
