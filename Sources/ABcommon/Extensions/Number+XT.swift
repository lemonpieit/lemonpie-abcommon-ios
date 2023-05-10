//
//  Number+XT.swift
//  DiCEhome
//
//  Created by Francesco Leoni on 16/09/2020.
//  Copyright © 2020 DiCEworld S.r.l. All rights reserved.
//

import UIKit

extension Int {
  /// Converts an `Int` to `Double`.
  /// - Returns: a `Double`.
  func toDouble() -> Double {
    Double(self)
  }

  /// Converts an `Int` to `String`.
  /// - Returns: a `String`.
  func toString() -> String {
    "\(self)"
  }
}

extension Double {
  /// Converts an `Double` to `Int`.
  /// - Returns: a `Int`.
  func toInt() -> Int {
    Int(self)
  }

  /// Converts an `Double` to `String`.
  /// - Returns: a `String`.
  func toString() -> String {
    String(format: "%.02f", self)
  }
}
