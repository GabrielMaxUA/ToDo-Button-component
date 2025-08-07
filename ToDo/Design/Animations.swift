//
//  Animations.swift
//  ToDo
//
//  Created by Max Gabriel on 2025-08-06.
//

import UIKit

// Seting an animation to uiview of our setting modal shown on the screen
extension UIView {
  func scaleUpAnimation() {
    self.transform = CGAffineTransform(scaleX: 0, y: 0)
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 15, options: [.curveEaseInOut]) {
      self.transform = CGAffineTransform(scaleX: 1, y: 1)
    }
  }
}

