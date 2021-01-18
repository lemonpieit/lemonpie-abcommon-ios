//
//  ViewController.swift
//  ABcommon
//
//  Created by Francesco Leoni on 03/18/2020.
//  Copyright (c) 2020 Francesco Leoni. All rights reserved.
//

import UIKit
import ABcommon

class NViewController: UITableViewController, NavigationControllerAppearanceContext {
    
  func title(for navigationController: UINavigationController) -> String? {
    "Title"
  }
  
  func prefersLargeTitle(for navigationController: UINavigationController) -> Bool? {
    true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    view.backgroundColor = .red
    tableView.alwaysBounceVertical = true
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.navigationController?.pushViewController(NextVc(), animated: true)
    }
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

class NextVc: UIViewController, NavigationControllerAppearanceContext {
  
  func largeTitleDisplayMode(for navigationController: UINavigationController) -> UINavigationItem.LargeTitleDisplayMode {
    .always
  }
  
  func title(for navigationController: UINavigationController) -> String? {
    "Next"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .blue
  }  

}
