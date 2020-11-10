//
//  ViewController.swift
//  ABcommon
//
//  Created by Francesco Leoni on 03/18/2020.
//  Copyright (c) 2020 Francesco Leoni. All rights reserved.
//

import UIKit
import ABcommon

class NViewController: ViewController {
  
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
  
  lazy var mm = MailManager(delegate: self)
  
  override func setUp() {
    mm.sendEmail(to: [""])
    navigationController?.configureNavigationBar(style: Style.first)
  }
}

extension NViewController: MailManagerDelegate {
  func errorOccurred(_ error: Error) {
    
  }
  
  
}
