//
//  UIView+XT.swift
//  CustomerArea
//
//  Created by Luigi Aiello on 24/02/2020.
//  Copyright © 2020 ABenergie S.p.A. All rights reserved.
//

import UIKit

public extension UIView {
    /// Set the corner radius with a ratio.
    /// - Parameter ratio: The ratio used to calculate the corner radius. it is multiplied by the width of the view.
    func setRoundedCorners(ratio: Double?) {
        if let radio = ratio {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = self.frame.size.width * CGFloat(radio)
        } else {
            
            // circle
            // i would put a condition, as width and height differ:
            if self.frame.size.width == self.frame.size.height {
                self.layer.masksToBounds = true
                self.layer.cornerRadius = self.frame.size.width/2 // for circles
            } else {
                //
            }
        }
    }
    
    
    /// Set the value for corner radius.
    /// - Parameter value: The corner radius value.
    func setRoundedCorners(value: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = value
    }
    
    /// Add a gradient layer to the view sublayer.
    /// - Parameter colors: An array of colors used by the gradient layer.
    func applyGradient(colors: [UIColor]) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
    }
}
