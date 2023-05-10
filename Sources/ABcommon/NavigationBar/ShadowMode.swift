//
//  ShadowMode.swift
//  ABcommon
//
//  Created by Francesco Leoni on 28/10/21.
//

import UIKit

public enum ShadowMode {
  
  case alwaysVisible
  case alwaysHidden
  case onlyForLargeTitle
  case onlyForSmallTitle
  case onlyIfCanScroll
  
  func isHidden(for viewController: UIViewController) -> Bool {
    let largeTitle = viewController.navigationItem.largeTitleDisplayMode
    
    switch self {
    case .alwaysVisible: return false
    case .alwaysHidden: return true
    case .onlyForLargeTitle:
      switch largeTitle {
      case .always, .automatic: return false
      case .never: return true
      @unknown default: return false
      }
    case .onlyForSmallTitle:
      switch largeTitle {
      case .always, .automatic: return true
      case .never: return false
      @unknown default: return false
      }
    case .onlyIfCanScroll:
      if viewController is UITableViewDataSource ||
          viewController is UICollectionViewDataSource ||
          viewController is UIScrollViewDelegate {
        return false
      } else {
        return true
      }
    }
  }
}
