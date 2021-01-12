import Foundation
import UIKit
import QuartzCore

public class AppearanceApplyingStrategy {
  
  public func apply(appearance: Appearance?,
                    toNavigationController navigationController: UINavigationController,
                    animated: Bool) {
    if let appearance = appearance {
      let navigationBar = navigationController.navigationBar
      let toolbar = navigationController.toolbar
      
      if !navigationController.isNavigationBarHidden {
        if #available(iOS 13.0, *) {
          let navBarAppearance = UINavigationBarAppearance()
          navBarAppearance.backgroundColor = appearance.navigationBar.backgroundColor
          //                navBarAppearance.shadowColor = .clear
          navBarAppearance.largeTitleTextAttributes = [.foregroundColor: appearance.navigationBar.tintColor]
          navBarAppearance.titleTextAttributes = [.foregroundColor: appearance.navigationBar.tintColor]
          navigationBar.standardAppearance = navBarAppearance
          navigationBar.compactAppearance = navBarAppearance
          navigationBar.scrollEdgeAppearance = navBarAppearance
          navigationBar.tintColor = appearance.navigationBar.tintColor
          navigationBar.barTintColor = appearance.navigationBar.barTintColor
        } else {
          navigationBar.tintColor = appearance.navigationBar.tintColor
          navigationBar.barTintColor = appearance.navigationBar.backgroundColor
          //                navigationBar.shadowImage = UIImage()
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
