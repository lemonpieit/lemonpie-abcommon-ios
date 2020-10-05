//
//  Collection+XT.swift
//  DiCEhome
//
//  Created by Francesco Leoni on 28/07/2020.
//  Copyright © 2020 DiCEworld S.r.l. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
