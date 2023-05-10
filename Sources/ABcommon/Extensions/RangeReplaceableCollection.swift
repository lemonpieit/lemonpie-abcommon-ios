//
//  File.swift
//  
//
//  Created by Francesco Leoni on 13/12/22.
//

import Foundation

public extension RangeReplaceableCollection where Element: Equatable {
  
  /// Removes `object` from the array.
  /// - Parameter object: The object to remove.
  @discardableResult
  mutating func remove(object element: Element) -> Element? {
    if let index = firstIndex(of: element) {
      return remove(at: index)
    }
    return nil
  }
  
  /// Removes  multiple`objects` from the array.
  /// - Parameter objects: The objects to remove.
  @discardableResult
  mutating func remove(objects elements: [Element]) -> [Element] {
    var removedObjects: [Element] = []
    
    for element in elements {
      if let index = firstIndex(of: element) {
        removedObjects.append(remove(at: index))
      }
    }
    
    return removedObjects
  }
  
  mutating func swap(_ element: Element, with newElement: Element) {
    if let elementIndex = firstIndex(of: element) {
      self.remove(at: elementIndex)
      self.insert(newElement, at: elementIndex)
    }
  }
}
