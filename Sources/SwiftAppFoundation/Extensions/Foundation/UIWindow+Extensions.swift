//  UIWindow+Extensions.swift
//  AppFoundation
//
//  Created by Edmund Ng on 2020-06-11.
//
import UIKit

extension UIWindow {
    public func topViewController() -> UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}