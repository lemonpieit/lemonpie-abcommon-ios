
import Foundation
import UIKit


public struct Appearance: Equatable {
  
  static var defaultAppearance: Appearance?

  public struct Bar: Equatable {
    
    public var style: UIBarStyle = .default
    
    /// The backgound color of the `UINavigationBar` or `UIToolbar`.
    public var backgroundColor = UIColor.white
    
    /// The tint color to apply to the navigation items and bar button items.
    public var tintColor = UIColor.black
    
    /// The tint color to apply to the navigation bar background.
    public var barTintColor: UIColor?
  }
  
  public var statusBarStyle: UIStatusBarStyle = .default
  public var navigationBar = Bar()
  public var toolbar = Bar()
  
  public init() { }

  /// Set the default appearance for the navigation bar.
  ///
  /// - Note: You should set the default appearance only once,
  /// if you assign a new default appearance multiple times the old appearance will be overridden.
  /// - Parameter appearance: The new default appearance.
  public static func setDefaultAppearance(to appearance: Appearance) {
    self.defaultAppearance = appearance
  }
}

public func ==(lhs: Appearance.Bar, rhs: Appearance.Bar) -> Bool {
  return lhs.style == rhs.style &&
    lhs.backgroundColor == rhs.backgroundColor &&
    lhs.tintColor == rhs.tintColor &&
    rhs.barTintColor == lhs.barTintColor
}

public func ==(lhs: Appearance, rhs: Appearance) -> Bool {
  return lhs.statusBarStyle == rhs.statusBarStyle && lhs.navigationBar == rhs.navigationBar && lhs.toolbar == rhs.toolbar
}
