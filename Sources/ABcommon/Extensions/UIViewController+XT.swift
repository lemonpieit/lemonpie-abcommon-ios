//
//  UIViewController+XT.swift
//  CustomerArea
//
//  Created by Francesco Leoni on 20/02/2020.
//  Copyright © 2020 ABenergie S.p.A. All rights reserved.
//

import SafariServices
import UIKit.UIViewController

public extension UIViewController {

  /// The frame of the status bar.
  var statusBarFrame: CGRect {
    if #available(iOS 13.0, *) {
      return view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
    } else {
      return UIApplication.shared.statusBarFrame
    }
  }
  
  /// Removes back button item string.
  func removeBackButtonString() {
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }

  /// Hides back button item.
  func removeBackButton() {
    navigationItem.hidesBackButton = true
  }
  
  /// Adds a `UIViewController` as a child to the parent `UIViewController`.
  /// - Parameter child: The child `UIViewController` to add.
  func add(_ child: UIViewController) {
    addChild(child)
    view.addSubview(child.view)
    child.didMove(toParent: self)
  }
  
  /// Removes a child `UIViewController` from the parent `UIViewController`.
  func remove() {
    guard parent != nil else {
      return
    }
    
    willMove(toParent: nil)
    view.removeFromSuperview()
    removeFromParent()
  }

  /// Dismisses the keyboard
  func dismissKeyboard() {
    view.endEditing(true)
  }

  /// Opens the app settings in the Settings app.
  func openSettings() {
    if let url = URL(string: UIApplication.openSettingsURLString) {
      if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
    }
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

  /// Removes the first separator between header and cell.
  /// - Parameters:
  ///   - indexPath: The table view indexPath.
  ///   - cell: The table view cell.
  func removeHeaderSeparator(indexPath: IndexPath, cell: UITableViewCell) {
    if indexPath.row == 0, let divider = cell.subviews.filter({ $0.frame.minY == 0 && $0 !== cell.contentView }).first {
      divider.isHidden = true
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
      let to = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
    else {
      return nil
    }

    return Keyboard(animationCurve: curve, duration: time, frameBegins: from, ends: to)
  }

  /// Creates an `ActionSheet`.
  /// - Parameters:
  ///   - title: The title of the `UIAlertController`.
  ///   - message: The message of the `UIAlertController`.
  ///   - actions: The `UIAlertAction` to perform.
  func createActionSheet(title: String? = nil, message: String? = nil, tintColor: UIColor, showCancel: Bool = true, actions: [UIAlertAction]) {
    createAlertController(title: title, message: message, style: .actionSheet, tintColor: tintColor, showCancel: showCancel, actions: actions)
  }

  /// Creates an `UIAlertController` with multiple actions.
  ///
  /// Add the key `alert_controller_cancel_button` to your `Localizable.strings` file to localize the cancel button title.
  ///
  /// - Parameters:
  ///   - title: The title of the `UIAlertController`.
  ///   - message: The message of the `UIAlertController`.
  ///   - showCancel: Bool indicating whether to show the cancel button.
  ///   - style: The style of the `UIAlertController`.
  ///   - tintColor: The tiint color of the `UIAlertController`.
  ///   - actions: The `UIAlertAction` to perform.
  func createAlertController(title: String? = nil, message: String? = nil, style: UIAlertController.Style = .alert, tintColor: UIColor? = nil, showCancel: Bool = true, actions: [UIAlertAction] = []) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    alert.view.tintColor = tintColor
    alert.pruneNegativeWidthConstraints()

    for index in 0 ..< actions.count {
      alert.addAction(actions[index])
    }

    if showCancel {
      let button = UIAlertAction(title: NSLocalizedString("alert_controller_cancel_button", value: "Cancel", comment: "Cancel"), style: .cancel) { _ in
        alert.dismiss(animated: true, completion: nil)
      }
      alert.addAction(button)
    }

    present(alert, animated: true, completion: nil)
  }

  /// Present a view controller created in storyboard.
  /// - Parameters:
  ///   - class: The `class` of the view controller.
  ///   - controllerId: The `id` of the view controller.
  ///   - storyboardId: The `storyboardId` of the view controller.
  ///   - navBarId: The `navBarId`.
  func presentController<T>(_: T.Type, withIdentifier controllerId: String, storyboardId: String, navBarId: String) {
    let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: controllerId) as? T
    let destinationNavigationController = storyboard.instantiateViewController(withIdentifier: navBarId) as? UINavigationController
    guard
      let viewController = controller as? UIViewController,
      let navController = destinationNavigationController else { return }

    navController.navigationBar.topItem?.title = ""
    navController.pushViewController(viewController, animated: true)
    navController.modalPresentationStyle = .fullScreen
    navController.modalTransitionStyle = .crossDissolve

    present(navController, animated: true, completion: nil)
  }

  // MARK: - Nested structs

  struct Keyboard {
    private(set) var animationCurve = UIView.AnimationCurve.linear
    private(set) var animationDuration = 0.25
    private(set) var frameBegin = CGRect.zero
    private(set) var frameEnd = CGRect.zero

    init(animationCurve curve: UIView.AnimationCurve, duration: Double, frameBegins from: CGRect, ends end: CGRect) {
      animationCurve = curve
      animationDuration = duration
      frameBegin = from
      frameEnd = end
    }
  }
}
