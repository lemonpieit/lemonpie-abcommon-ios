//
//  UIView+XT.swift
//  CustomerArea
//
//  Created by Luigi Aiello on 24/02/2020.
//  Copyright © 2020 ABenergie S.p.A. All rights reserved.
//

import UIKit

public extension UIView {
  
  enum Edge {
    case top
    case leading
    case bottom
    case trailing
    
    public enum Set {
      case top
      case leading
      case bottom
      case trailing
      case all
      case horizontal
      case vertical
    }
  }
  
  enum Alignment {
    case center
    case leading
    case trailing
    case top
    case bottom
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
  }
  
  enum BorderStyle {
    case inside
    case outside
    case middle
  }
  
  enum AnchorRelation {
    case equalTo
    case greaterThanOrEqualTo
    case lessThanOrEqualTo
  }
  
  enum ViewEdge {
    case top(CGFloat = 0)
    case leading(CGFloat = 0)
    case bottom(CGFloat = 0)
    case trailing(CGFloat = 0)
    
    public enum Anchor {
      case top(_ relation: AnchorRelation = .equalTo, to: NSLayoutYAxisAnchor?, pad: CGFloat = 0)
      case leading(_ relation: AnchorRelation = .equalTo, to: NSLayoutXAxisAnchor?, pad: CGFloat = 0)
      case bottom(_ relation: AnchorRelation = .equalTo, to: NSLayoutYAxisAnchor?, pad: CGFloat = 0)
      case trailing(_ relation: AnchorRelation = .equalTo, to: NSLayoutXAxisAnchor?, pad: CGFloat = 0)
    }
  }
  
  enum SizeAnchor {
    case width(_ relation: AnchorRelation = .equalTo, _ costant: CGFloat)
    case height(_ relation: AnchorRelation = .equalTo, _ costant: CGFloat)
  }
  
  enum Center {
    case x(CGFloat = 0)
    case y(CGFloat = 0)
    
    public enum Anchor {
      case x(to: NSLayoutXAxisAnchor?, pad: CGFloat = 0)
      case y(to: NSLayoutYAxisAnchor?, pad: CGFloat = 0)
    }
  }
  
  /// Pin a UIView to the defined anchors.
  @discardableResult
  func pin(_ anchors: ViewEdge.Anchor...) -> Self {
    translatesAutoresizingMaskIntoConstraints = false
    
    for anchor in anchors {
      switch anchor {
      case .top(let relation, let anchor, let constant):
        if let anchor = anchor {
          assign(toAnchor: topAnchor, itemAnchor: anchor, relation: relation, constant: constant)
        }
      case .leading(let relation, let anchor, let constant):
        if let anchor = anchor {
          assign(toAnchor: leadingAnchor, itemAnchor: anchor, relation: relation, constant: constant)
        }
      case .bottom(let relation, let anchor, let constant):
        if let anchor = anchor {
          assign(toAnchor: bottomAnchor, itemAnchor: anchor, relation: relation, constant: -constant)
        }
      case .trailing(let relation, let anchor, let constant):
        if let anchor = anchor {
          assign(toAnchor: trailingAnchor, itemAnchor: anchor, relation: relation, constant: -constant)
        }
      }
    }
    return self
  }
  
  /// Pin a `UIView` to the defined anchors superview.
  @discardableResult
  func pinToSuperview(edges: ViewEdge...) -> Self {
    guard let superview = superview else { return self }
    
    translatesAutoresizingMaskIntoConstraints = false
    
    for edge in edges {
      switch edge {
      case .top(let padding):
        pin(.top(to: superview.topAnchor, pad: padding))
        
      case .leading(let padding):
        pin(.leading(to: superview.leadingAnchor, pad: padding))
        
      case .bottom(let padding):
        pin(.bottom(to: superview.bottomAnchor, pad: padding))
        
      case .trailing(let padding):
        pin(.trailing(to: superview.trailingAnchor, pad: padding))
      }
    }
    return self
  }
  
  /// Adds an anchor on the four edges of the `UIView`.
  @discardableResult
  func fillSuperview(padding: CGFloat) -> Self {
    pinToSuperview(edges: .top(padding), .leading(padding), .bottom(padding), .trailing(padding))
    return self
  }
    
  /// Center a UIView to the defined anchors.
  @discardableResult
  func center(_ axes: Center.Anchor...) -> Self {
    translatesAutoresizingMaskIntoConstraints = false
    
    for axis in axes {
      switch axis {
      case .x(let anchor, let constant):
        if let anchor = anchor {
          centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
      case .y(let anchor, let constant):
        if let anchor = anchor {
          centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
      }
    }
    return self
  }
  
  /// Center a UIView to the defined anchors superview.
  @discardableResult
  func centerToSuperview(_ axes: Center...) -> Self {
    translatesAutoresizingMaskIntoConstraints = false
    
    for axis in axes {
      switch axis {
      case .x(let padding):
        center(.x(to: superview?.centerXAnchor, pad: padding))
        
      case .y(let padding):
        center(.y(to: superview?.centerYAnchor, pad: padding))
      }
    }
    return self
  }
  
  /// Defines the size of a UIView.
  @discardableResult
  func size(_ sizes: SizeAnchor...) -> Self {
    translatesAutoresizingMaskIntoConstraints = false
    
    for size in sizes {
      switch size {
      case .width(let relation, let constant):
        assign(toAnchor: widthAnchor, relation: relation, constant: constant)
        
      case .height(let relation, let constant):
        assign(toAnchor: heightAnchor, relation: relation, constant: constant)
      }
    }
    return self
  }
  
  // MARK: - Helpers
  
  private func assign(toAnchor anchor: NSLayoutDimension, relation: AnchorRelation, constant: CGFloat) {
    switch relation {
    case .equalTo:
      anchor.constraint(equalToConstant: constant).isActive = true
      
    case .greaterThanOrEqualTo:
      anchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
      
    case .lessThanOrEqualTo:
      anchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
    }
  }
  
  private func assign(toAnchor anchor: NSLayoutXAxisAnchor, itemAnchor: NSLayoutXAxisAnchor, relation: AnchorRelation, constant: CGFloat) {
    switch relation {
    case .equalTo:
      anchor.constraint(equalTo: itemAnchor, constant: constant).isActive = true
      
    case .greaterThanOrEqualTo:
      anchor.constraint(greaterThanOrEqualTo: itemAnchor, constant: constant).isActive = true
      
    case .lessThanOrEqualTo:
      anchor.constraint(lessThanOrEqualTo: itemAnchor, constant: constant).isActive = true
    }
  }
  
  private func assign(toAnchor anchor: NSLayoutYAxisAnchor, itemAnchor: NSLayoutYAxisAnchor, relation: AnchorRelation, constant: CGFloat) {
    switch relation {
    case .equalTo:
      anchor.constraint(equalTo: itemAnchor, constant: constant).isActive = true
      
    case .greaterThanOrEqualTo:
      anchor.constraint(greaterThanOrEqualTo: itemAnchor, constant: constant).isActive = true
      
    case .lessThanOrEqualTo:
      anchor.constraint(lessThanOrEqualTo: itemAnchor, constant: constant).isActive = true
    }
  }
  
  /* General extensions */
  
  /// Removes every separator line in the current view.
  func removeEverySeparator() {
    subviews.forEach { view in
      if String(describing: type(of: view)) == "_UITableViewCellSeparatorView" {
        view.removeFromSuperview()
      }
    }
  }
  
  /// Defines whether the user switched between dark modes and performs updates.
  /// - Parameters:
  ///   - previousTraitCollection: The previous interface style.
  ///   - updates: The updates to perform.
  func shouldUpdate(for previousTraitCollection: UITraitCollection?, updates: () -> Void) {
    if #available(iOS 12.0, *) {
      if traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
        updates()
      }
    }
  }
  
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
}
