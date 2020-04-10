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
        self.masksToBounds = false
        self.shadowColor = UIColor.black.cgColor
        self.shadowOffset = .zero
        self.shadowRadius = 8
        self.roundedCorners()
        self.shadowOpacity = 0.2
    }
    
    /// Configure the shadow layer.
    /// - Parameters:
    ///   - color: The color of the layer’s shadow. Animatable.
    ///   - radius: The blur radius (in points) used to render the layer’s shadow. Animatable.
    ///   - opacity: The opacity of the layer’s shadow. Animatable.
    func configureShadows(withColor color: UIColor, radius: CGFloat, opacity: Float) {
        self.masksToBounds = false
        self.shadowColor = color.cgColor
        self.shadowOffset = .zero
        self.shadowRadius = radius
        self.roundedCorners()
        self.shadowOpacity = opacity
    }
    
    /// Makes the shorter sides of the layer rounded.
    func roundedCorners() {
        if self.frame.width >= self.frame.height {
            self.cornerRadius = self.frame.height / 2
        } else {
            self.cornerRadius = self.frame.width / 2
        }
    }
}
