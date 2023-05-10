//
//  UIEdgeInsets+XT.swift
//  ABcommon
//
//  Created by Francesco Leoni on 29/10/2020.
//

import UIKit

public extension UIEdgeInsets {
  
  init(top: CGFloat) {
    self.init(top: top, left: 0, bottom: 0, right: 0)
  }

  init(left: CGFloat) {
    self.init(top: 0, left: left, bottom: 0, right: 0)
  }

  init(bottom: CGFloat) {
    self.init(top: 0, left: 0, bottom: bottom, right: 0)
  }

  init(right: CGFloat) {
    self.init(top: 0, left: 0, bottom: 0, right: right)
  }

  init(vertical: CGFloat) {
    self.init(top: vertical, left: 0, bottom: vertical, right: 0)
  }

  init(horizontal: CGFloat) {
    self.init(top: 0, left: horizontal, bottom: 0, right: horizontal)
  }

  init(vertical: CGFloat, horizontal: CGFloat) {
    self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
  }

  init(all: CGFloat) {
    self.init(top: all, left: all, bottom: all, right: all)
  }

  var horizontal: CGFloat { return left + right }
  
  var vertical: CGFloat { return top + bottom }
  
  static func all(_ value: CGFloat) -> UIEdgeInsets {
    UIEdgeInsets(all: value)
  }
}
