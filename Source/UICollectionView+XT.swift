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
        let item: Int = self.numberOfItems(inSection: section) - 1
        let lastIndexPath = IndexPath(item: item, section: section)
        self.scrollToItem(at: lastIndexPath, at: postion, animated: animated)
    }
}

