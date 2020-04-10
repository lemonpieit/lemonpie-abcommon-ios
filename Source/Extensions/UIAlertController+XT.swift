//
//  UIAlertController+XT.swift
//  ABcommon
//
//  Created by Francesco Leoni on 23/03/2020.
//

import Foundation

public extension UIAlertController {
    // Bug fix
    func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}
