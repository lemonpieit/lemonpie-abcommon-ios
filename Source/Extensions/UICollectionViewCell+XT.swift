//
//  UICollectionViewCell+XT.swift
//  ABcommon
//
//  Created by Francesco Leoni on 09/04/21.
//

import UIKit

public extension UICollectionViewCell {
    
    /// Adds shadow to the cell.
    func addShadows(color: UIColor = .black, offset: CGSize = .zero, radius: CGFloat = 7, opacity: Float = 0.15) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
    }
}
