//
//  UIImage+XT.swift
//  BikeApp
//
//  Created by Francesco Colleoni on 28/02/17.
//  Copyright © 2017 Mindtek srl. All rights reserved.
//

import UIKit

public extension UIImage {
  /// Returns an instance of UIImage rendered as `alwaysOriginal`.
  var original: UIImage {
    return withRenderingMode(.alwaysOriginal)
  }

  /// Returns an instance of UIImage rendered as `alwaysTemplate`.
  var template: UIImage {
    return withRenderingMode(.alwaysTemplate)
  }

  /// Returns an UIImage with some insets.
  /// - Parameter insets: UIEdgeInsets.
  func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(
      CGSize(width: size.width + insets.left + insets.right, height: size.height + insets.top + insets.bottom), false, scale
    )
    _ = UIGraphicsGetCurrentContext()
    let origin = CGPoint(x: insets.left, y: insets.top)
    draw(at: origin)
    let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return imageWithInsets
  }

  /// Resizes an image to the given size.
  /// - Parameter targetSize: The target CGSize.
  func resizeImage(targetSize: CGSize) -> UIImage {
    let size = self.size
    let widthRatio = targetSize.width / size.width
    let heightRatio = targetSize.height / size.height

    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if widthRatio > heightRatio {
      newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
      newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
    }

    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
    draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage!
  }

  /// Draws the image inside a circle.
  /// - Parameters:
  ///   - size: The size of the circle.
  ///   - color: The color of the circle.
  func getColoredThumbImage(size: CGSize, color: UIColor) -> UIImage {
    let circle = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    circle.layer.cornerRadius = circle.frame.width / 2
    circle.backgroundColor = color

    // we add circle to a view, that is bigger than circle so we have extra 10 points for the shadow
    let view = UIView(frame: CGRect(x: 0, y: 0, width: size.width + 10, height: size.height + 10))
    view.backgroundColor = UIColor.clear
    view.addSubview(circle)
    circle.center = view.center

    // here we are rendering view to image, so we can use it later
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
    view.drawHierarchy(in: circle.bounds, afterScreenUpdates: true)
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
    UIGraphicsEndImageContext()

    return image
  }

  /// Draws the image inside a circle.
  /// - Parameter color: The color of the circle.
  /// - Parameter circleDiameter: The diameter of the circle.
  func getColoredThumbImage(circleDiameter: CGFloat, color: UIColor) -> UIImage {
    // we will make circle with this diameter
    let edgeLen: CGFloat = circleDiameter

    // circle will be created from UIView
    let circle = UIView(frame: CGRect(x: 0, y: 0, width: edgeLen, height: edgeLen))
    circle.backgroundColor = color
    circle.clipsToBounds = true
    circle.isOpaque = false

    // in the layer we add corner radius to make it circle and add shadow
    circle.layer.cornerRadius = edgeLen / 2
    circle.layer.shadowColor = UIColor.black.cgColor
    circle.layer.shadowOffset = CGSize(width: 1, height: 1)
    circle.layer.shadowRadius = 2
    circle.layer.shadowOpacity = 0.5
    circle.layer.masksToBounds = false

    // we add circle to a view, that is bigger than circle so we have extra 10 points for the shadow
    let view = UIView(frame: CGRect(x: 0, y: 0, width: edgeLen + 10, height: edgeLen + 10))
    view.backgroundColor = UIColor.clear
    view.addSubview(circle)

    circle.center = view.center

    // here we are rendering view to image, so we can use it later
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
    view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return image!
  }
}
