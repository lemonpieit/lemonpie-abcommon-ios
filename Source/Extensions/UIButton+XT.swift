//
//  UIButton+XT.swift
//  CustomerArea
//
//  Created by Luigi Aiello on 20/02/2020.
//  Copyright © 2020 ABenergie S.p.A. All rights reserved.
//

import UIKit.UIButton
import UIKit.UIColor

public extension UIButton {
  /// ABenergie default hollow button.
  func hollowButton() {
    layer.roundedCorners()
    layer.borderColor = UIColor.white.cgColor
    layer.borderWidth = 2
  }
}
