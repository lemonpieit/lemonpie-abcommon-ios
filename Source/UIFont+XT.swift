//
//  UIFont+XT.swift
//  CustomerArea
//
//  Created by Francesco Leoni on 02/03/2020.
//  Copyright © 2020 ABenergie S.p.A. All rights reserved.
//

import UIKit.UIFont

public extension UIFont {
    /// Returns the rounded version of the system font.
    /// - Parameters:
    ///   - fontSize: The size of the font.
    ///   - weight: The weigh of the font.
    /// - Important: Available on iOS 13 or newer.
    class func roundedFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: weight)
        let font: UIFont
        
        if #available(iOS 13.0, *) {
            if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
                font = UIFont(descriptor: descriptor, size: fontSize)
            } else {
                font = systemFont
            }
        } else {
            font = systemFont
        }
        
        return font
    }
}
