//
//  CALayer+XT.swift
//  CustomerArea
//
//  Created by Francesco Leoni on 19/02/2020.
//  Copyright © 2020 ABenergie S.p.A. All rights reserved.
//

import QuartzCore.CALayer
import UIKit.UIColor

public extension CALayer {
  /// ABenergie default shadows
  func defaultShadows() {
    masksToBounds = false
    shadowColor = UIColor.black.cgColor
    shadowOffset = .zero
    shadowRadius = 8
    roundedCorners()
    shadowOpacity = 0.2
  }

  /// Configure the shadow layer.
  /// - Parameters:
  ///   - color: The color of the layer’s shadow. Animatable.
  ///   - radius: The blur radius (in points) used to render the layer’s shadow. Animatable.
  ///   - opacity: The opacity of the layer’s shadow. Animatable.
  func configureShadows(withColor color: UIColor, radius: CGFloat, opacity: Float) {
    masksToBounds = false
    shadowColor = color.cgColor
    shadowOffset = .zero
    shadowRadius = radius
    roundedCorners()
    shadowOpacity = opacity
  }

  /// Makes the shorter sides of the layer rounded.
  func roundedCorners() {
    if frame.width >= frame.height {
      cornerRadius = frame.height / 2
    } else {
      cornerRadius = frame.width / 2
    }
  }
}
