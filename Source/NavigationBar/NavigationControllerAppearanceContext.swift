
import Foundation
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

/// Conform to `NavigationControllerAppearanceContext` to define the behaviour of the `UINavigationBar` and `UITollbar`.
public protocol NavigationControllerAppearanceContext: class {
  
  /// Defines when to show the navbar shadow.
  var shadowMode: ShadowMode { get }

  /// Sets the title of the current navigation item.
  ///
  /// - Parameter navigationController: The `UINavigationController` to which apply this property.
  func title(for navigationController: UINavigationController) -> String?

  /// A Boolean value indicating whether the title should be displayed in a large format.
  ///
  /// - Note: Use this method only on the first view controller of the navigation controller.
  /// Then use `largeTitleDisplayMode(for:)` to control the size of the title.
  ///
  /// - Parameter navigationController: The `UINavigationController` to which apply this property.
  func prefersLargeTitle(for navigationController: UINavigationController) -> Bool?
  
  /// The mode for displaying the title of the navigation bar.
  ///
  /// When large titles are available, this property controls how the navigation bar displays the navigation item's title.
  ///
  /// The default value of this property is `.automatic`, which causes the title to use the same styling as the previously displayed navigation item.
  ///
  /// - Note: If the `prefersLargeTitles` property of the navigation bar is false, this property has no effect and the navigation item's title is always displayed as a small title.
  ///
  /// - Parameter navigationController: The `UINavigationController` to which apply this property.
  func largeTitleDisplayMode(for navigationController: UINavigationController) -> UINavigationItem.LargeTitleDisplayMode
  
  /// Sets whether the navigation bar is hidden.
  /// The default value is `false`.
  ///
  /// - Parameter navigationController: The `UINavigationController` to which apply this property.
  func prefersNavigationbarHidden(for navigationController: UINavigationController) -> Bool
  
  /// Sets whether the toolbar is hidden.
  /// The default value is `true`.
  ///
  /// - Parameter navigationController: The `UINavigationController` to which apply this property.
  func prefersToolbarHidden(for navigationController: UINavigationController) -> Bool
  
  /// Specifies the preferred appearance of the `navigationBar` and `toolbar`.
  ///
  /// - Parameter navigationController: The `UINavigationController` to which apply this property.
  func preferredAppearance(for navigationController: UINavigationController) -> Appearance?
  
  /// Indicates to the system that the `navigationBar` and `toolbar` appearance have changed.
  func setNeedsUpdateNavigationControllerAppearance()
}

public extension NavigationControllerAppearanceContext {
    
  var shadowMode: ShadowMode {
    return Appearance.shadowMode
  }

  func title(for navigationController: UINavigationController) -> String? {
    return nil
  }
  
  func prefersLargeTitle(for navigationController: UINavigationController) -> Bool? {
    return nil
  }
  
  func largeTitleDisplayMode(for navigationController: UINavigationController) -> UINavigationItem.LargeTitleDisplayMode {
    return .automatic
  }

  func prefersNavigationbarHidden(for navigationController: UINavigationController) -> Bool {
    return false
  }
  
  func prefersToolbarHidden(for navigationController: UINavigationController) -> Bool {
    return true
  }
  
  func preferredAppearance(for navigationController: UINavigationController) -> Appearance? {
    return Appearance.defaultAppearance
  }
  
  func setNeedsUpdateNavigationControllerAppearance() {
    if let viewController = self as? UIViewController,
       let navigationController = viewController.navigationController as? AppearanceNavigationController {
      navigationController.updateAppearance(for: viewController)
    }
  }
}
