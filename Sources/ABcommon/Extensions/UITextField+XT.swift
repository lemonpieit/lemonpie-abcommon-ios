//
//  UITextField+XT.swift
//  CustomerArea
//
//  Created by Francesco Leoni on 20/02/2020.
//  Copyright © 2020 ABenergie S.p.A. All rights reserved.
//

import QuartzCore.CALayer
import UIKit.UITextField

public extension UITextField {
  /// Adds padding to the text inside the text field.
  /// - Parameters:
  ///   - leftAmount: The amount of padding for the left side.
  ///   - rightAmount: The amount of padding for the right side.
  func padding(left leftAmount: CGFloat? = nil, right rightAmount: CGFloat? = nil) {
    if let leftAmount = leftAmount {
      let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftAmount, height: frame.height))
      leftView = leftPaddingView
      leftViewMode = .always
    }

    if let rightAmount = rightAmount {
      let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: rightAmount, height: frame.height))
      rightView = rightPaddingView
      rightViewMode = .always
    }
  }

  /// ABenergie default text field
  func standardTextField() {
    padding(left: 20, right: 20)
    layer.defaultShadows()
  }

  /// Sets a bottom border of a text field.
  /// - Parameter color: The color of the border.
  func setBottomBorder(withColor color: UIColor = .gray) {
    borderStyle = .none
    layer.backgroundColor = UIColor.white.cgColor
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 1)
    layer.shadowOpacity = 1
    layer.shadowRadius = 0
  }
}
