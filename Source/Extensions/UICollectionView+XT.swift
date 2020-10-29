//
//  CollectionView+XT.swift
//  BikeApp
//
//  Created by Luigi Aiello on 01/08/17.
//  Copyright © 2017 Mindtek srl. All rights reserved.
//

import UIKit

public extension UICollectionView {
  /// Scrolls to the given section.
  /// - Parameters:
  ///   - postion: The position of the scroll view.
  ///   - section: The last section to scroll to.
  ///   - animated: Whether it is animated.
  func scrollToLast(_ postion: UICollectionView.ScrollPosition = .right, inSection section: Int = 0, animated: Bool = true) {
    let item: Int = numberOfItems(inSection: section) - 1
    let lastIndexPath = IndexPath(item: item, section: section)
    scrollToItem(at: lastIndexPath, at: postion, animated: animated)
  }

  /// Returns the last cell index of a given section.
  /// - Parameter section: The section to use.
  /// - Returns: The last index path of a section.
  func lastIndexPathForSection(_ section: Int) -> IndexPath? {
    if numberOfItems(inSection: section) > 0 {
      return IndexPath(item: numberOfItems(inSection: section) - 1, section: section)
    }
    return nil
  }
}

extension UICollectionViewCell {
  /// The index path of the cell.
  var indexPath: IndexPath? {
    var superview = self.superview

    while superview != nil {
      if superview is UICollectionView { break }
      superview = superview?.superview
    }

    guard let collectionView = superview as? UICollectionView else { return nil }

    for path in collectionView.indexPathsForVisibleItems {
      guard
        let cell = collectionView.cellForItem(at: path), cell == self
      else { continue }

      return path
    }
    return nil
  }
}
