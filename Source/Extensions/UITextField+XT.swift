//
//  UITextField+XT.swift
//  CustomerArea
//
//  Created by Francesco Leoni on 20/02/2020.
//  Copyright © 2020 ABenergie S.p.A. All rights reserved.
//

import UIKit.UITextField
import QuartzCore.CALayer

public extension UITextField {
    
    /// Adds padding to the text inside the text field.
    /// - Parameters:
    ///   - leftAmount: The amount of padding for the left side.
    ///   - rightAmount: The amount of padding for the right side.
    func padding(left leftAmount: CGFloat? = nil, right rightAmount: CGFloat? = nil) {
        if let leftAmount = leftAmount {
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftAmount, height: self.frame.height))
            self.leftView = leftPaddingView
            self.leftViewMode = .always
        }
        
        if let rightAmount = rightAmount {
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: rightAmount, height: self.frame.height))
            self.rightView = rightPaddingView
            self.rightViewMode = .always
        }
    }
    
    /// ABenergie default text field
    func standardTextField() {
        self.padding(left: 20, right: 20)
        self.layer.defaultShadows()
    }
    
    /// Sets a bottom border of a text field.
    /// - Parameter color: The color of the border.
    func setBottomBorder(withColor color: UIColor = .gray) {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 0
    }
}
