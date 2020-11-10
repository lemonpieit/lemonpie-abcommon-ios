//
//  Gradient.swift
//  
//
//  Created by Francesco Leoni on 20/10/2020.
//

/// Wrapper around the information needed to define a gradient.
public struct Gradient: Equatable {
  
  /// Type of the gradient used to map `CAGradientLayerType`.
  public enum GradientType: Int {
    case linear
    case radial
    case conic
    
    var gradientLayerType: CAGradientLayerType? {
      switch self {
      case .linear:
        return .axial
      case .radial:
        return .radial
      case .conic:
        if #available(iOS 12.0, *) {
          return .conic
        } else {
          return .radial
        }
      }
    }
  }
  
  /// Points where a gradient can start/end.
  public enum Point {
    case custom(CGPoint)
    case top, bottom, left, right
    case topLeft, topRight, bottomLeft, bottomRight
    case center
    
    fileprivate var point: CGPoint {
      switch self {
      case .center:
        return CGPoint(x: 0.5, y: 0.5)
        
      case .top:
        return CGPoint(x: 0.5, y: 0.0)
        
      case .bottom:
        return CGPoint(x: 0.5, y: 1.0)
        
      case .left:
        return CGPoint(x: 0.0, y: 0.5)
        
      case .right:
        return CGPoint(x: 1.0, y: 0.5)
        
      case .topLeft:
        return CGPoint(x: 0.0, y: 0.0)
        
      case .topRight:
        return CGPoint(x: 1.0, y: 0.0)
        
      case .bottomLeft:
        return CGPoint(x: 0.0, y: 1.0)
        
      case .bottomRight:
        return CGPoint(x: 1.0, y: 1.0)
        
      case .custom(let value):
        return value
      }
    }
  }
  
  /// Colors to use in the gradient.
  /// Note that order matters.
  public var colors: [UIColor]
  
  /// Position where the gradient color sequence starts.
  public var startPoint: CGPoint
  
  /// Position where the gradient color sequence ends.
  public var endPoint: CGPoint
  
  /// Location of each color-stop as a value in the range [0, 1].
  /// The values must be monotonically increasing.
  public var locations: [CGFloat]
  
  /// The type of the gradient.
  public var type: GradientType
  
  /// Creates an instance of `Gradient` with the given values.
  ///
  /// - Parameters:
  ///   - colors: the colors to use in the gradient. Note that order matters.
  ///   - startPoint: the position where the gradient color sequence starts.
  ///   - endPoint: the position where the gradient color sequence ends.
  ///   - locations: location of each color stop as a value in the range [0,1].
  ///   - type: type of the gradient, see GradientType.
  public init(colors: [UIColor],
              startPoint: CGPoint,
              endPoint: CGPoint,
              locations: [CGFloat] = [],
              type: GradientType = .linear) {
    self.colors = colors
    self.startPoint = startPoint
    self.endPoint = endPoint
    self.locations = locations
    self.type = type
  }
  
  /// Creates an instance of `Gradient` with the given values.
  ///
  /// - Parameters:
  ///   - colors: the colors to use in the gradient. Note that order matters.
  ///   - startPoint: the position where the gradient color sequence starts.
  ///   - endPoint: the position where the gradient color sequence ends.
  ///   - locations: location of each color stop as a value in the range [0,1].
  ///   - type: type of the gradient, see GradientType.
  public init(colors: [UIColor],
              startPoint: Point,
              endPoint: Point,
              locations: [CGFloat] = [],
              type: GradientType = .linear) {
    self.init(colors: colors, startPoint: startPoint.point, endPoint: endPoint.point, locations: locations, type: type)
  }
  
  /// Creates a linear black/clear gradient from top to bottom.
  public init() {
    self.init(colors: [.black, .clear], startPoint: .top, endPoint: .bottom)
  }
  
  /// Flips the gradient inverting start and end points.
  public var flipped: Gradient {
    return Gradient(
      colors: self.colors,
      startPoint: self.endPoint,
      endPoint: self.startPoint,
      locations: self.locations,
      type: self.type
    )
  }
  
  /// Inverts the colors of the gradient.
  public var inverted: Gradient {
    return Gradient(
      colors: self.colors.reversed(),
      startPoint: self.startPoint,
      endPoint: self.endPoint,
      locations: self.locations,
      type: self.type
    )
  }
  
  /// Tries to apply gradient to the given layer.
  /// If it cannot apply it, the first color of the gradient is set as solid background color.
  ///
  /// - Parameter layer: The layer to which apply the gradien.
  public func apply(to layer: CAGradientLayer) {
    guard let gradientLayerType = self.type.gradientLayerType else {
      layer.backgroundColor = self.colors.first?.cgColor
      return
    }
    layer.colors = self.colors.map { $0.cgColor }
    layer.startPoint = self.startPoint
    layer.endPoint = self.endPoint
    layer.type = gradientLayerType
    
    if !self.locations.isEmpty {
      layer.locations = self.locations as [NSNumber]?
    }
  }
  
  /// Tries to apply gradient to the given view.
  /// If it cannot apply it, the first color of the gradient is set as solid background color.
  ///
  /// - Parameter view: The view to which apply the gradien.
  public func apply(to view: UIView) {
    guard let gradientLayerType = self.type.gradientLayerType else {
      view.backgroundColor = self.colors.first
      return
    }
    
    let layer = CAGradientLayer()
    layer.frame = view.bounds
    layer.colors = self.colors.map { $0.cgColor }
    layer.startPoint = self.startPoint
    layer.endPoint = self.endPoint
    layer.type = gradientLayerType
    
    if !self.locations.isEmpty {
      layer.locations = self.locations as [NSNumber]?
    }
    
    view.layer.masksToBounds = true
    view.layer.insertSublayer(layer, at: 0)
  }
  
}

public extension Gradient {
  /// A completely transparent gradient.
  static let clear = Gradient(colors: [.clear, .clear], startPoint: .top, endPoint: .bottom)
}
