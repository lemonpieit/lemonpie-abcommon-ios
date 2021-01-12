//
//  UIView+XT.swift
//  CustomerArea
//
//  Created by Luigi Aiello on 24/02/2020.
//  Copyright © 2020 ABenergie S.p.A. All rights reserved.
//

import UIKit

public extension UIView {
  /// Creates a dash border.
  /// - Parameter cornerRadius: The `cornerRadius` of the `CGRect`.
  func addDashedBorder(cornerRadius: CGFloat = 0) {
    let color = UIColor.black.cgColor

    let shapeLayer = CAShapeLayer()
    let frameSize = frame.size
    let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

    shapeLayer.bounds = shapeRect
    shapeLayer.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = color
    shapeLayer.lineWidth = 2
    shapeLayer.lineJoin = CAShapeLayerLineJoin.round
    shapeLayer.lineDashPattern = [6, 3]
    shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: cornerRadius).cgPath

    layer.addSublayer(shapeLayer)
  }

  /// Set the corner radius with a ratio.
  /// - Parameter ratio: The ratio used to calculate the corner radius. it is multiplied by the width of the view.
  func setRoundedCorners(ratio: Double?) {
    if let radio = ratio {
      layer.masksToBounds = true
      layer.cornerRadius = frame.size.width * CGFloat(radio)
    } else {
      // circle
      // i would put a condition, as width and height differ:
      if frame.size.width == frame.size.height {
        layer.masksToBounds = true
        layer.cornerRadius = frame.size.width / 2 // for circles
      } else {
        //
      }
    }
  }

  /// Set the value for corner radius.
  /// - Parameter value: The corner radius value.
  func setRoundedCorners(value: CGFloat) {
    layer.masksToBounds = true
    layer.cornerRadius = value
  }

  /// Add a gradient layer to the view sublayer.
  /// - Parameter colors: An array of colors used by the gradient layer.
  func applyGradient(colors: [UIColor]) {
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    gradient.colors = colors.map { $0.cgColor }
    gradient.startPoint = CGPoint(x: 1, y: 0)
    gradient.endPoint = CGPoint(x: 0, y: 1)
    layer.masksToBounds = true
    layer.insertSublayer(gradient, at: 0)
  }

  /// Renders a UIView as an UIImage.
  func asImage() -> UIImage {
    let renderer = UIGraphicsImageRenderer(bounds: bounds)
    return renderer.image { rendererContext in
      layer.render(in: rendererContext.cgContext)
    }
  }

  /// Returns the constraint with the specified identifier.
  /// - Parameter identifier: The identifier of the constraint.
  func constraint(withIdentifier identifier: String) -> NSLayoutConstraint? {
    return constraints.filter {
      $0.identifier == identifier
    }.first
  }

  /// Loads a `Nib` file.
  /// - Parameters:
  ///   - nibName: The name of the `Nib` file.
  ///   - type: The class of the `Nib` file.
  func load<T>(fromNibNamed nibName: String, withType _: T.Type) -> T? {
    return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as? T ?? nil
  }

  /// Dismisses the receiver's  keyboard.
  func dismissKeyboard() {
    endEditing(true)
  }

  /// Blurs out the view.
  /// - Parameter style: The blur effect style.
  func addBlur(style: UIBlurEffect.Style = .regular) -> UIVisualEffectView {
    let blurEffect = UIBlurEffect(style: style)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(blurEffectView)

    return blurEffectView
  }

  // Anchors
  struct AnchoredConstraints {
    public var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
  }

  @discardableResult
  func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
    translatesAutoresizingMaskIntoConstraints = false
    var anchoredConstraints = AnchoredConstraints()

    if let top = top { anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top) }

    if let leading = leading { anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left) }

    if let bottom = bottom { anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom) }

    if let trailing = trailing { anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right) }

    if size.width != 0 { anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width) }

    if size.height != 0 { anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height) }

    [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach { $0?.isActive = true }

    return anchoredConstraints
  }

  @discardableResult
  func fillSuperview(padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
    translatesAutoresizingMaskIntoConstraints = false
    let anchoredConstraints = AnchoredConstraints()

    guard let superviewTopAnchor = superview?.topAnchor,
          let superviewBottomAnchor = superview?.bottomAnchor,
          let superviewLeadingAnchor = superview?.leadingAnchor,
          let superviewTrailingAnchor = superview?.trailingAnchor
    else {
      return anchoredConstraints
    }

    return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
  }

  @discardableResult
  func fillSuperviewSafeAreaLayoutGuide(padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
    let anchoredConstraints = AnchoredConstraints()

    guard let superviewTopAnchor = superview?.safeAreaLayoutGuide.topAnchor,
          let superviewBottomAnchor = superview?.safeAreaLayoutGuide.bottomAnchor,
          let superviewLeadingAnchor = superview?.safeAreaLayoutGuide.leadingAnchor,
          let superviewTrailingAnchor = superview?.safeAreaLayoutGuide.trailingAnchor
    else {
      return anchoredConstraints
    }
    return anchor(top: superviewTopAnchor, leading: superviewLeadingAnchor, bottom: superviewBottomAnchor, trailing: superviewTrailingAnchor, padding: padding)
  }

  func centerToSuperview() {
    translatesAutoresizingMaskIntoConstraints = false
    if let superviewCenterXAnchor = superview?.centerXAnchor {
      centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
    }

    if let superviewCenterYAnchor = superview?.centerYAnchor {
      centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
    }
  }

  func centerXTo(_ anchor: NSLayoutXAxisAnchor) {
    translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: anchor).isActive = true
  }

  func centerYTo(_ anchor: NSLayoutYAxisAnchor) {
    translatesAutoresizingMaskIntoConstraints = false
    centerYAnchor.constraint(equalTo: anchor).isActive = true
  }

  func centerXToSuperview() {
    translatesAutoresizingMaskIntoConstraints = false
    if let superviewCenterXAnchor = superview?.centerXAnchor {
      centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
    }
  }

  func centerYToSuperview() {
    translatesAutoresizingMaskIntoConstraints = false
    if let superviewCenterYAnchor = superview?.centerYAnchor {
      centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
    }
  }
}
