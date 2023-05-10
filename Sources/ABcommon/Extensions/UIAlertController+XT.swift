//
//  UIAlertController+XT.swift
//  ABcommon
//
//  Created by Francesco Leoni on 23/03/2020.
//

import UIKit

public extension UIAlertController {
  // Bug fix
  func pruneNegativeWidthConstraints() {
    for subView in view.subviews {
      for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
        subView.removeConstraint(constraint)
      }
    }
  }
}
