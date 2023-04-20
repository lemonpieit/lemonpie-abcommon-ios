//
//  NavBarAppearance.swift
//  ABcommon
//
//  Created by Francesco Leoni on 28/10/21.
//

import UIKit

public typealias NavBarAppearance = Appearance

@available(*, deprecated, renamed: "NavBarAppearance")
public struct Appearance: Equatable {
  
  static var defaultAppearance: NavBarAppearance?
  static var defaultDisplayMode: UINavigationItem.LargeTitleDisplayMode = .automatic
  static var shadowMode: ShadowMode = .alwaysVisible

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
  /// Use this method inside the `AppDelegate`.
  ///
  /// You should set the default appearance only once,
  /// if you assign a new default appearance multiple times the old appearance will be overridden.
  ///
  /// Instead of setting the default value multiple times, override the `preferredAppearance(for:)` method inside a specific `UIViewController`.
  /// - Parameter appearance: The new default appearance.
  public static func setDefaultAppearance(to appearance: NavBarAppearance) {
    self.defaultAppearance = appearance
  }
    
  /// Set the default display mode for the navigation bar.
  /// Use this method inside the `AppDelegate`.
  ///
  /// You should set the default display mode only once,
  /// if you assign a new default display mode multiple times the old value will be overridden.
  ///
  /// Instead of setting the default value multiple times, override the `largeTitleDisplayMode(for:)` method inside a specific `UIViewController`.
  /// - Parameter appearance: The new default appearance.
  public static func setDefaultLargeTitleDisplayMode(_ displayMode: UINavigationItem.LargeTitleDisplayMode) {
    self.defaultDisplayMode = displayMode
  }

  /// Set the default shadow mode for the navigation bar shadow visibility.
  /// Use this method inside the `AppDelegate`.
  ///
  /// You should set the default appearance only once,
  /// if you assign a new default appearance multiple times the old appearance will be overridden.
  ///
  /// Instead of setting the default value multiple times, override the `shadowMode` property inside a specific `UIViewController`.
  /// - Parameter shadowMode: The new default shadow mode.
  public static func setShadowVisibility(_ shadowMode: ShadowMode) {
    self.shadowMode = shadowMode
  }
}

public func ==(lhs: NavBarAppearance.Bar, rhs: NavBarAppearance.Bar) -> Bool {
  return lhs.style == rhs.style &&
    lhs.backgroundColor == rhs.backgroundColor &&
    lhs.tintColor == rhs.tintColor &&
    rhs.barTintColor == lhs.barTintColor
}

public func ==(lhs: NavBarAppearance, rhs: NavBarAppearance) -> Bool {
  return lhs.statusBarStyle == rhs.statusBarStyle && lhs.navigationBar == rhs.navigationBar && lhs.toolbar == rhs.toolbar
}
