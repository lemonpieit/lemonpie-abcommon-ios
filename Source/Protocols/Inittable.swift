//
//  Protocols.swift
//
//  Created by Francesco Leoni on 13/06/2020.
//

import UIKit

protocol Inittable {
  static var nibName: String { get }
  var nibContentView: UIView { get }
  
  func loadNib()
}

extension Inittable where Self: UIView {
  static var nibName: String {
    return String(describing: self)
  }
  
  func loadNib() {
    Bundle.main.loadNibNamed(Self.nibName, owner: self, options: nil)
    addSubview(nibContentView)
    nibContentView.frame = self.bounds
    nibContentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
  }
}
