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
        self.layer.roundedCorners()
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
    }
}
