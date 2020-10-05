//
//  UINavigationController+XT.swift
//  ABcommon
//
//  Created by Francesco Leoni on 30/09/2020.
//

import UIKit.UINavigationController

public protocol Navigatable {
    var titleColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var tintColor: UIColor { get }
}

public extension UINavigationController {
    /// Pops to the first `UIViewController` of a given type.
    /// - Parameters:
    ///   - ofClass: The class of the `UIViewController`.
    ///   - animated: Whether the transition is animated.
    func popToFirstViewController(ofClass: AnyClass, animated: Bool = true) {
        if let viewController = viewControllers.filter({$0.isKind(of: ofClass)}).first {
            popToViewController(viewController, animated: animated)
        }
    }
    
    /// Pops to the last `UIViewController` of a given type.
    /// - Parameters:
    ///   - ofClass: The class of the `UIViewController`.
    ///   - animated: Whether the transition is animated.
    func popToLastViewController(ofClass: AnyClass, animated: Bool = true) {
        if let viewController = viewControllers.filter({$0.isKind(of: ofClass)}).last {
            popToViewController(viewController, animated: animated)
        }
    }
    
    /// Pops back to a given number of `UIViewController`.
    /// - Parameter number: The number of `UIViewController` to pop.
    func popBackTo(number: Int) {
        let viewControllers: [UIViewController] = self.viewControllers as [UIViewController]
        popToViewController(viewControllers[viewControllers.count - (number + 1)], animated: true)
    }
    
    /// Configure the status bar with the given background color.
    /// - Parameter backgroundColor: The color of the status bar.
    func configureStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        
        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: statusBarFrame.width, height: statusBarFrame.height))
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
            
    /// Configures the `UINavigationController`.
    /// - Parameters:
    ///   - style: The style of the `navigationBar`. It must be an enum that conforms to `Navigatable` and implements every property.
    ///   - preferredLargeTitle: Whether the title is large.
    ///   - largeTitleDisplayMode: The mode for displaying the title of the navigation bar.
    ///
    /// - Experiment:
    ///
    /// Create a `Style` enum that conforms to `Navigatable`:
    ///
    ///     enum Style: Navigatable {
    ///         case first
    ///         case second
    ///
    ///         var titleColor: UIColor {
    ///            switch self {
    ///            case .first: return .red
    ///            case .second: return .blue
    ///            }
    ///         }
    ///         ...
    ///      }
    func configureNavigationBar(style: Navigatable, preferredLargeTitle: Bool? = nil, largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode? = nil) {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: style.titleColor]
            navBarAppearance.titleTextAttributes = [.foregroundColor: style.titleColor]
            navBarAppearance.backgroundColor = style.backgroundColor
            navBarAppearance.shadowColor = .clear
            self.navigationBar.standardAppearance = navBarAppearance
            self.navigationBar.compactAppearance = navBarAppearance
            self.navigationBar.scrollEdgeAppearance = navBarAppearance
            self.navigationBar.tintColor = style.tintColor

            // FIXME: Non funziona
            if let largeTitleDisplayMode = largeTitleDisplayMode {
                self.navigationItem.largeTitleDisplayMode = largeTitleDisplayMode
            }

            if let largeTitle = preferredLargeTitle {
                self.navigationBar.prefersLargeTitles = largeTitle
            }
        } else {
            self.navigationBar.barTintColor = style.backgroundColor
            self.navigationBar.tintColor = style.tintColor
            self.navigationBar.largeTitleTextAttributes = [.foregroundColor: style.titleColor]
            self.navigationBar.titleTextAttributes = [.foregroundColor: style.titleColor]
            self.navigationBar.shadowImage = UIImage()
            
            if let largeTitle = preferredLargeTitle {
                self.navigationBar.prefersLargeTitles = largeTitle
            }
        }
    }
}
