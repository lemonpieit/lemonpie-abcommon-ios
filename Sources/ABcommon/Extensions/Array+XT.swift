//
//  Array+XT.swift
//  BikeApp
//
//  Created by Francesco Colleoni on 30/01/17.
//  Copyright © 2017 Mindtek srl. All rights reserved.
//

import UIKit

public extension Array {
  
  /// Maps the array to a specific key path.
  func map<T>(_ value: KeyPath<Element, T>) -> [T] {
      self.map { $0[keyPath: value] }
  }
}

public extension Array where Element == NSLayoutConstraint {
    
    /// Activates every contraint in the array.
    func activate() {
        self.forEach { $0.isActive = true }
    }
    
    /// Deactivates every contraint in the array.
    func deactivate() {
        self.forEach { $0.isActive = false }
    }
}

public extension Array where Element == UIView {
    
    /// Adds every view to the specified UIView.
    func addTo(_ view: UIView) {
        self.forEach(view.addSubview)
    }
    
    /// Adds every view to the specified UIStackView.
    func addTo(_ view: UIStackView) {
        self.forEach(view.addArrangedSubview)
    }
}

public extension Array where Element: Equatable {
  /// Removes `object` from the array.
  /// - Parameter object: The object to remove.
  mutating func remove(object: Element) {
    if let index = firstIndex(of: object) {
      remove(at: index)
    }
  }

  /// Removes  multiple`objects` from the array.
  /// - Parameter objects: The objects to remove.
  mutating func remove(objects: Element...) {
    objects.forEach { object in
      if let index = firstIndex(of: object) {
        remove(at: index)
      }
    }
  }

  subscript(safe index: Int) -> Element? {
    let count = self.count

    if index < count {
      return self[index]
    } else {
      return nil
    }
  }

  /// Returns a new array with the first elements up to specified distance being shifted to the end of the collection.
  /// If the distance is negative, returns a new array with the last elements up to the specified absolute distance being shifted to the beginning of the collection.

  /// If the absolute distance exceeds the number of elements in the array, the elements are not shifted.
  /// - Parameters:
  ///   - distance: The number of position to shift the `Element`.
  /// - Returns: An array of `Element`
  func shift(withDistance distance: Int = 1) -> [Element] {
    let offsetIndex = distance >= 0 ?
      self.index(startIndex, offsetBy: distance, limitedBy: endIndex) :
      self.index(endIndex, offsetBy: distance, limitedBy: startIndex)

    guard let index = offsetIndex else { return self }
    return Array(self[index ..< endIndex] + self[startIndex ..< index])
  }

  /// Shifts the first elements up to specified distance to the end of the array.
  /// If the distance is negative, shifts the last elements up to the specified absolute distance to the beginning of the array.
  /// If the absolute distance exceeds the number of elements in the array, the elements are not shifted.
  /// - Parameters:
  ///   - distance: The number of position to shift the `Element`.
  mutating func shiftInPlace(withDistance distance: Int = 1) {
    self = shift(withDistance: distance)
  }
}
