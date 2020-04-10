//
//  UIBarButtonItem+XT.swift
//  BikeApp
//
//  Created by Luigi Aiello on 29/08/17.
//  Copyright © 2017 Mindtek srl. All rights reserved.
//

import Foundation

public extension UIBarButtonItem {
    /// Hides the bar item.
    func hidden() {
        self.isEnabled = false
        self.tintColor = .clear
    }
    
    /// Shows the bar item.
    /// - Parameters:
    /// - Color: The tint color of the button.
    func show(color: UIColor) {
        self.isEnabled = true
        self.tintColor = color
    }
}
