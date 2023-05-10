//
//  AppearanceApplyingStrategy.swift
//  ABcommon
//
//  Created by Francesco Leoni on 28/10/21.
//

import UIKit
import QuartzCore

public class AppearanceApplyingStrategy {
  
  public func apply(appearance: NavBarAppearance?,
                    toNavigationController navigationController: UINavigationController,
                    animated: Bool) {
    if let appearance = appearance {
      let navigationBar = navigationController.navigationBar
      let toolbar = navigationController.toolbar
      
      if !navigationController.isNavigationBarHidden {
        if #available(iOS 13.0, *) {
          [navigationBar.standardAppearance,
           navigationBar.compactAppearance,
           navigationBar.scrollEdgeAppearance].forEach { app in
            app?.backgroundColor = appearance.navigationBar.backgroundColor
            app?.largeTitleTextAttributes = [.foregroundColor: appearance.navigationBar.tintColor]
            app?.titleTextAttributes = [.foregroundColor: appearance.navigationBar.tintColor]
          }

          navigationBar.tintColor = appearance.navigationBar.tintColor
          navigationBar.barTintColor = appearance.navigationBar.barTintColor
        } else {
          navigationBar.tintColor = appearance.navigationBar.tintColor
          navigationBar.barTintColor = appearance.navigationBar.backgroundColor
          navigationBar.largeTitleTextAttributes = [.foregroundColor: appearance.navigationBar.tintColor]
          navigationBar.titleTextAttributes = [.foregroundColor: appearance.navigationBar.tintColor]
        }
      }
      
      if !navigationController.isToolbarHidden {
        toolbar?.backgroundColor = appearance.toolbar.backgroundColor
        toolbar?.tintColor = appearance.toolbar.tintColor
        toolbar?.barTintColor = appearance.toolbar.barTintColor
      }
    }
  }
}
