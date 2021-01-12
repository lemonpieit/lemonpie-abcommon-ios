//
//  ViewController.swift
//  ABcommon
//
//  Created by Francesco Leoni on 03/18/2020.
//  Copyright (c) 2020 Francesco Leoni. All rights reserved.
//

import UIKit
import ABcommon

class NViewController: UIViewController {
    
  override func viewDidLoad() {
    super.viewDidLoad()
  }
    
  enum Style: Navigatable {
    case first
    
    var tintColor: UIColor {
      switch self {
      case .first: return .blue
      }
    }
    
    var backgroundColor: UIColor {
      switch self {
      case .first: return .green
      }
    }
    
    var titleColor: UIColor {
      switch self {
      case .first: return .red
      }
    }
  }
}
