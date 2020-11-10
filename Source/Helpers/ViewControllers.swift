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
public protocol HasDataSource: class {
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

/// Use this `ViewController` if you need a `ViewModel` without an internal `Delegate`.
open class BaseViewModelVC<BVM: BaseViewModel>: ViewController, HasBaseViewModel {
  
  open var viewModel: BVM!
  
  open override func viewDidLoad() {
    configureBaseViewModel()
    super.viewDidLoad()
  }
}

/// Use this `ViewController` if you need a `ViewModel` with an internal `Delegate`.
open class ViewModelVC<VM: ViewModel>: ViewController, HasViewModel {
  
  open var viewModel: VM!
  
  open override func viewDidLoad() {
    configureViewModel()
    super.viewDidLoad()
  }
}

/// Use this `ViewController` if you need a `DataSource`.
open class DataSourceVC<DS: DataSource>: ViewController, HasDataSource {
  
  open var dataSource: DS!
  
  open override func viewDidLoad() {
    configureDataSource()
    super.viewDidLoad()
  }
}

/// Use this `ViewController` if you need a `DataSource` and a `ViewModel` without an internal `Delegate`.
open class BaseViewModelDataSourceVC<BVM: BaseViewModel, DS: DataSource>: ViewController, HasBaseViewModel, HasDataSource {
  
  open var viewModel: BVM!
  open var dataSource: DS!
  
  open override func viewDidLoad() {
    configureBaseViewModel()
    configureDataSource()
    super.viewDidLoad()
  }
}

/// Use this `ViewController` if you need a `DataSource` and a `ViewModel` with an internal `Delegate`.
open class ViewModelDataSourceVC<VM: ViewModel, DS: DataSource>: ViewController, HasViewModel, HasDataSource {
  
  open var viewModel: VM!
  open var dataSource: DS!
  
  open override func viewDidLoad() {
    configureViewModel()
    configureDataSource()
    super.viewDidLoad()
  }
}

/// Use this `ViewController` if you don't need a `ViewModel` or even a `DataSource`.
open class ViewController: UIViewController {
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
    configureUI()
    configureTexts()
    configureCollectionView()
    configureTableView()
  }
  
  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureNavigationBar()
  }
  
  
  // MARK: - Configurations
  
  /// Use this method to set up the view controller.
  open func setUp() { }
  
  /// Use this method to configure the navigation controller.
  /// This method is called every time the view appear.
  ///
  /// Use `super.configureNavigationBar()` if you want to hide the back button string.
  open func configureNavigationBar() {
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }
  
  /// Use this method to configure the graphic elements.
  open func configureUI() { }
  
  /// Use this method to configure every text and localization of the view controller.
  open func configureTexts() { }
  
  /// Use this method to configure the `collectionView` if needed.
  open func configureCollectionView() { }
  
  /// Use this method to configure the `tableView` if needed.
  open func configureTableView() { }
}
