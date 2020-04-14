//
//  Array+XT.swift
//  BikeApp
//
//  Created by Francesco Colleoni on 30/01/17.
//  Copyright © 2017 Mindtek srl. All rights reserved.
//

import Foundation

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
        objects.forEach { (object) in
            if let index = firstIndex(of: object) {
                remove(at: index)
            }
        }
    }
}