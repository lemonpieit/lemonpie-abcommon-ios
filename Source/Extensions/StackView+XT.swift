//
//  UIStackView+XT.swift
//  MTEvents
//
//  Created by Giovanni Liboni on 12/03/17.
//  Copyright © 2017 NearIT. All rights reserved.
//

import UIKit

public extension UIStackView {
    /// Removes all the stack view subviews.
    func removeAllArrangedSubviews() {
        for view in self.arrangedSubviews {
            self.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    /// Removes a subview at the specified index.
    func removeArrangedSubviews(fromIndex index: Int) {
        guard self.arrangedSubviews.count > 0, self.arrangedSubviews.count > index else {
            return
        }
        for i in (index ..< self.arrangedSubviews.count).reversed() {
            let view = self.arrangedSubviews[i]
            self.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
