//
//  File.swift
//  
//
//  Created by Francesco Leoni on 13/12/22.
//

import UIKit

public extension UIApplication {
  
  static var currentWindow: UIWindow? {
    UIApplication.shared.windows.filter { $0.isKeyWindow }.first
  }
}
