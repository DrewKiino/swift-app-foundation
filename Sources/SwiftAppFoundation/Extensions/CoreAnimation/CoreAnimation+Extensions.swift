//
//  CoreAnimation+Extensions.swift
//  App
//
//  Created by Andrew Aquino on 4/9/19.
//

import UIKit

extension UIView {
  public func fadeTransition(_ duration: CFTimeInterval) {
    let animation = CATransition()
    animation.timingFunction = CAMediaTimingFunction(
      name: .linear
    )
    animation.type = .fade
    animation.duration = duration
    layer.add(animation, forKey: CATransitionType.fade.rawValue)
  }
}
