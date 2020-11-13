//
//  ViewControllers.swift
//
//  Created by Francesco Leoni on 30/10/2020.
//  Copyright © 2020 Francesco Leoni. All rights reserved.
//

import UIKit

/// Defines a class/struct/enum as an empty `ViewModel`.
public protocol BaseViewModel {
  
  init()
}

/// Defines a class/struct/enum as a `ViewModel` with an internal `Delegate`.
public protocol ViewModel: BaseViewModel {
  associatedtype Delegate
  
  /// The `Delegate` that connects the `Controller` with the `ViewModel`.
  var delegate: Delegate? { get set }
  
  init(delegate: Delegate)
}

public extension ViewModel {
  init(delegate: Delegate) {
    self.init()
    self.delegate = delegate
  }
}

/// Defines a class/struct/enum as a `DataSource` with an internal `Delegate`.
public protocol DataSource: BaseViewModel {
  associatedtype DataSourceDelegate
  
  /// The `DataSourceDelegate` that connects the `Controller` with the `DataSource`.
  var delegate: DataSourceDelegate? { get set }
  
  init(delegate: DataSourceDelegate)
}

public extension DataSource {
  init(delegate: DataSourceDelegate) {
    self.init()
    self.delegate = delegate
  }
}

/// Use this protocol if a class must have a `ViewModel` without an internal `Delegate`.
public protocol HasBaseViewModel: class {
  associatedtype BVM: BaseViewModel
  
  var viewModel: BVM! { get set }
}

public extension HasBaseViewModel {
  func configureBaseViewModel() {
    viewModel = BVM()
  }
}

/// Use this protocol if a class must have a `ViewModel` with an internal `Delegate`.
public protocol HasViewModel: class {
  associatedtype VM: ViewModel
  
  var viewModel: VM! { get set }
}

public extension HasViewModel {
  func configureViewModel() {
    guard let delegate = self as? VM.Delegate else {
      viewModel = VM()
      return
    }
    viewModel = VM(delegate: delegate)
  }
}

/// Use this protocol if a class must have a `DataSource` with an internal `Delegate`.
public  protocol HasDataSource: class {
  associatedtype DS: DataSource
  
  var dataSource: DS! { get set }
}

public extension HasDataSource {
  func configureDataSource() {
    guard let delegate = self as? DS.DataSourceDelegate else {
      dataSource = DS()
      return
    }
    dataSource = DS(delegate: delegate)
  }
}
