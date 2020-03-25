//
//  UIStoryboard+XT.swift
//  BikeApp
//
//  Created by Francesco Colleoni on 20/01/17.
//  Copyright © 2017 Mindtek srl. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    /// Returns an instance of the view controller identified by `identifier` and defined in the specified storyboard.
    /// - Parameters:
    ///   - identifier: The identifier of the `UIViewController` that should be instantiated and defined in the storyboard.
    ///   - storyboardName: The name of the storyboard that should include the view controller.
    /// - Returns: An instance of `UIViewController`.
    func viewController(withIdentifier identifier: String, fromStoryboardNamed storyboardName: String) -> UIViewController {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    /// Returns the initial view controller defined in the specified storyboard.
    /// - Parameters:
    ///   - parameter StoryboardName: The name of the storyboard that should include the view controller.
    /// - Returns: An instance of `UIViewController`, `nil` if the storyboard does not define an initial view controller.
    func initialViewController(withStoryboardNamed storyboardName: String) -> UIViewController? {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()
    }
}
