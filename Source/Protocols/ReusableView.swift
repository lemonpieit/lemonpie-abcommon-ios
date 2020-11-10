//
//  ReusableView.swift
//  
//
//  Created by Francesco Leoni on 07/11/2020.
//

import UIKit

/// A protocol that aguments an `UIView` with a reuse identifier. Meant to be used for `UICollectionViewCell`, `UITableViewCell` and `UICollectionReusableView`.
public protocol ReusableView: UIView {
  
  /// The reusable identifier of the cell.
  static var reuseIdentifier: String { get }
}

public extension ReusableView {
  static var reuseIdentifier: String {
    String(describing: self.self)
  }
}

public extension UICollectionView {
  /// Dequeue a cell with proper typing.
  ///
  /// - parameters:
  ///   - type: the type of cell to dequeue.
  ///   - indexPath: the index path of the cell.
  /// - warning: the method will crash in case of wrong combination of type and index path.
  func dequeueReusableCell<C: ReusableView>(_ type: C.Type, for indexPath: IndexPath) -> C {
    let cell = dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier, for: indexPath)
    guard let typedCell = cell as? C else {
      fatalError("Cannot decode cell for \(indexPath) of type \(type)")
    }
    return typedCell
  }
  
  /// Register a nib.
  func registerNib<C: ReusableView>(_ cellClass: C.Type) {
    register(UINib(nibName: cellClass.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cellClass.reuseIdentifier)
  }
  
  /// Register a cell.
  func register<C: ReusableView>(_ cellClass: C.Type) {
    register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
  }
  
  /// Dequeue a header with proper typing.
  ///
  /// - parameters:
  ///   - type: the type of header to dequeue.
  ///   - indexPath: the index path of the header.
  /// - warning: the method will crash in case of wrong combination of type and index path.
  func dequeueReusableHeader<C: ReusableView>(_ type: C.Type, for indexPath: IndexPath) -> C {
    let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: type.reuseIdentifier, for: indexPath)
    guard let typedHeader = header as? C else {
      fatalError("Cannot decode header for \(indexPath) of type \(type)")
    }
    return typedHeader
  }
  
  /// Register a header.
  func registerHeader<C: ReusableView>(_ cellClass: C.Type) {
    register(cellClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cellClass.reuseIdentifier)
  }
  
  /// Dequeue a footer with proper typing.
  ///
  /// - parameters:
  ///   - type: the type of footer to dequeue.
  ///   - indexPath: the index path of the header.
  /// - warning: the method will crash in case of wrong combination of type and index path.
  func dequeueReusableFooter<C: ReusableView>(_ type: C.Type, for indexPath: IndexPath) -> C {
    let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: type.reuseIdentifier, for: indexPath)
    guard let typedHeader = header as? C else {
      fatalError("Cannot decode footer for \(indexPath) of type \(type)")
    }
    return typedHeader
  }
  
  /// Register a footer.
  func registerFooter<C: ReusableView>(_ cellClass: C.Type) {
    register(cellClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: cellClass.reuseIdentifier)
  }
}

public extension UITableView {
  /// Helper to dequeue a cell with proper typing.
  ///
  /// - parameters:
  ///   - type: the type of cell to dequeue.
  ///   - indexPath: the index path of the cell.
  /// - warning: the method will crash in case of wrong combination of type and index path.
  func dequeueReusableCell<C: ReusableView>(_ type: C.Type, for indexPath: IndexPath) -> C {
    let cell = dequeueReusableCell(withIdentifier: type.reuseIdentifier, for: indexPath)
    guard let typedCell = cell as? C else {
      fatalError("Cannot decode cell for \(indexPath) of type \(type)")
    }
    return typedCell
  }
  
  /// Register a nib.
  func registerNib<C: ReusableView>(_ cellClass: C.Type) {
    register(UINib(nibName: cellClass.reuseIdentifier, bundle: nil), forCellReuseIdentifier: cellClass.reuseIdentifier)
  }
  
  /// Register a cell.
  func register<C: ReusableView>(_ cellClass: C.Type) {
    register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
  }
  
  /// Dequeue a header with proper typing.
  ///
  /// - parameters:
  ///   - type: the type of header to dequeue.
  ///   - indexPath: the index path of the header.
  /// - warning: the method will crash in case of wrong combination of type and index path.
  func dequeueHeaderFooter<C: ReusableView>(_ type: C.Type) -> C {
    let header = dequeueReusableHeaderFooterView(withIdentifier: type.reuseIdentifier)
    guard let typedHeader = header as? C else {
      fatalError("Cannot decode header of type \(type)")
    }
    return typedHeader
  }
  
  /// Register a header.
  func registerHeaderFooter<C: ReusableView>(_ cellClass: C.Type) {
    register(cellClass, forHeaderFooterViewReuseIdentifier: cellClass.reuseIdentifier)
  }
}
