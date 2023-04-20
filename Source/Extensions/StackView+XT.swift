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
    for view in arrangedSubviews {
      removeArrangedSubview(view)
    }
  }

  /// Removes a subview at the specified index.
  func removeArrangedSubviews(fromIndex index: Int) {
    guard arrangedSubviews.count > 0, arrangedSubviews.count > index else {
      return
    }
    for i in (index ..< arrangedSubviews.count).reversed() {
      let view = arrangedSubviews[i]
      removeArrangedSubview(view)
      view.removeFromSuperview()
    }
  }
}
