//
//  UITableView+XT.swift
//  ABcommon
//
//  Created by Francesco Leoni on 10/04/2020.
//

import Foundation

public extension UITableView {
  /// Returns whether the cell is the last of the `TableView`.
  /// - Parameter indexPath: The `IndexPath` of the cell.
  func isLastCell(_ indexPath: IndexPath) -> Bool {
    let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
    let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1

    return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
  }
}
