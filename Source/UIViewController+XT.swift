//
//  UIViewController+XT.swift
//  CustomerArea
//
//  Created by Francesco Leoni on 20/02/2020.
//  Copyright © 2020 ABenergie S.p.A. All rights reserved.
//

import UIKit.UIViewController
import SafariServices

public extension UIViewController {
    /// Removes back button item string.
    func removeBackButtonString() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    /// Hides back button item.
    func removeBackButton() {
        navigationItem.hidesBackButton = true
    }
    
    /// Set the navigation bar background and title.
    /// - Parameter title: The navigation bar title.
    /// - Parameter color: The navigation bar background color.
    func configureWhiteNavigationBar(withTitle title: String, backgroundColor color: UIColor) {
        navigationItem.title = title
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = color
    }
    
    /// Set the navigation bar transparent with title.
    /// - Parameter title: The navigation bar title.
    func configureTransparentNavigationBar(withTitle title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    /// Open an `URL` in the browser outside the app.
    /// - Parameter url: The `URL` to open.
    func openUrl(_ url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
    /// Open an `URL` in the browser inside the app.
    /// - Parameter url: The `URL` to open.
    func openUrlInApp(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        let safariVC = SFSafariViewController(url: url)
        
        DispatchQueue.main.async {
            self.present(safariVC, animated: true, completion: nil)
        }
    }
    
    /// Creates a header view with a label.
    /// - Parameters:
    ///   - title: The text of the label.
    ///   - font: The font of the label.
    ///   - textColor: The color of the text of the label.
    func configureHeaderView(with title: String, font: UIFont, textColor: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        let label = UILabel()
        label.text = title
        label.font = font
        label.textColor = textColor
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 7).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20).isActive = true
        view.addSubview(label)
        
        return view
    }
    
    /// Updates controls rendered on a view controller.
    ///
    /// This method should be used when the UI of a view controller should indicate that the app is using the network and the user interface should be disabled.
    /// - Parameters:
    ///   - flag: If `true`, views will be disabled and activity indicators will be animated.
    ///   - views: The `UIView` instances that should be resigned, disabled or updated according to the value of `flag`.
    func set(isUsingNetwork flag: Bool, views: UIView...) {
        if !flag {
            for view in view.subviews where view.tag == 100 {
                view.removeFromSuperview()
            }
        } else {
            let indicator = UIActivityIndicatorView(style: .white)
            indicator.startAnimating()
            
            let loadingScreen = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            loadingScreen.backgroundColor = UIColor(white: 0, alpha: 0.35)
            loadingScreen.tag = 100
            loadingScreen.addSubview(indicator)
            
            indicator.center = CGPoint(x: loadingScreen.frame.midX, y: loadingScreen.frame.midY)
            
            view.addSubview(loadingScreen)
        }
        
        for view in views {
            if let textField = view as? UITextField {
                textField.isEnabled = !flag
                textField.resignFirstResponder()
            }
            
            if let button = view as? UIButton {
                button.isEnabled = !flag
            }
        }
    }
    
    /// Pops view controllers on the navigation controller until the last controller on the stack is `self`.
    /// - Parameters:
    ///   - animated: If `true`, controllers will be "popped" with an animation.
    func popToSelf(animated: Bool) -> [UIViewController]? {
        return navigationController?.popToViewController(self, animated: animated)
    }
    
    /// Adds a listener to `self` for a specific notification for a given `name`, `selector`.
    /// - Parameters:
    ///   - name: The name of the notification.
    ///   - selector: The selector that should be triggered by the notification.
    ///   - object: The object used to configure the observer.
    func observe(notificationNamed name: NSNotification.Name?, with selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: object)
    }
    
    /// Translates an instance of `NSNotification` in a `Keyboard` instance.
    /// - Parameters:
    ///   - notification: The `NSNotification` instance.
    /// - Returns: a `Keyboard` instance if the notification can be parsed correctly, `nil` otherwise.
    func parse(keyboardNotification notification: NSNotification) -> Keyboard? {
        guard
            let curveRawValue = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int,
            let curve = UIView.AnimationCurve(rawValue: curveRawValue),
            let time = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let from = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect,
            let to = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return nil
        }
        
        return Keyboard(animationCurve: curve, duration: time, frameBegins: from, ends: to)
    }
    
    /// Creates an `UIAlertController` with multiple actions.
    /// - Parameters:
    ///   - title: The title of the `UIAlertController`.
    ///   - message: The message of the `UIAlertController`.
    ///   - showCancel: Bool indicating whether to show the cancel button.
    ///   - style: The style of the `UIAlertController`.
    ///   - tintColor: The tiint color of the `UIAlertController`.
    ///   - actions: The `UIAlertAction` to perform.
    func createAlertController(title: String? = nil, message: String? = nil, style: UIAlertController.Style, tintColor: UIColor? = nil, showCancel: Bool, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        alert.view.tintColor = tintColor
        alert.pruneNegativeWidthConstraints()
        
        for index in 0..<actions.count {
            alert.addAction(actions[index])
        }
        
        if showCancel {
            let button = UIAlertAction(title: "Cancel", style: .cancel) { action in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(button)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Nested structs
    struct Keyboard {
        private (set) var animationCurve = UIView.AnimationCurve.linear
        private (set) var animationDuration = 0.25
        private (set) var frameBegin = CGRect.zero
        private (set) var frameEnd = CGRect.zero
        
        init(animationCurve curve: UIView.AnimationCurve, duration: Double, frameBegins from: CGRect, ends end: CGRect) {
            animationCurve = curve
            animationDuration = duration
            frameBegin = from
            frameEnd = end
        }
    }
}
