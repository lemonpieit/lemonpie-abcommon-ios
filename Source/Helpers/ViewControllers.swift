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

extension ViewModel {
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

extension DataSource {
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

extension HasBaseViewModel {
  func configureBaseViewModel() {
    viewModel = BVM()
  }
}

/// Use this protocol if a class must have a `ViewModel` with an internal `Delegate`.
public protocol HasViewModel: class {
  associatedtype VM: ViewModel
  
  var viewModel: VM! { get set }
}

extension HasViewModel {
  func configureViewModel() {
    guard let delegate = self as? VM.Delegate else {
      viewModel = VM()
      return
    }
    viewModel = VM(delegate: delegate)
  }
}

/// Use this protocol if a class must have a `DataSource` with an internal `Delegate`.
private protocol HasDataSource: class {
  associatedtype DS: DataSource
  
  var dataSource: DS! { get set }
}

extension HasDataSource {
  func configureDataSource() {
    guard let delegate = self as? DS.DataSourceDelegate else {
      dataSource = DS()
      return
    }
    dataSource = DS(delegate: delegate)
  }
}

/// Use this `ViewController` if you need a `ViewModel` without an internal `Delegate`.
class BaseViewModelVC<BVM: BaseViewModel>: ViewController, HasBaseViewModel {
  
  var viewModel: BVM!
  
  override func viewDidLoad() {
    configureBaseViewModel()
    super.viewDidLoad()
  }
}

/// Use this `ViewController` if you need a `ViewModel` with an internal `Delegate`.
class ViewModelVC<VM: ViewModel>: ViewController, HasViewModel {
  
  var viewModel: VM!
  
  override func viewDidLoad() {
    configureViewModel()
    super.viewDidLoad()
  }
}

/// Use this `ViewController` if you need a `DataSource`.
class DataSourceVC<DS: DataSource>: ViewController, HasDataSource {
  
  var dataSource: DS!
  
  override func viewDidLoad() {
    configureDataSource()
    super.viewDidLoad()
  }
}

/// Use this `ViewController` if you need a `DataSource` and a `ViewModel` without an internal `Delegate`.
class BaseViewModelDataSourceVC<BVM: BaseViewModel, DS: DataSource>: ViewController, HasBaseViewModel, HasDataSource {
  
  var viewModel: BVM!
  var dataSource: DS!
  
  override func viewDidLoad() {
    configureBaseViewModel()
    configureDataSource()
    super.viewDidLoad()
  }
}

/// Use this `ViewController` if you need a `DataSource` and a `ViewModel` with an internal `Delegate`.
class ViewModelDataSourceVC<VM: ViewModel, DS: DataSource>: ViewController, HasViewModel, HasDataSource {
  
  var viewModel: VM!
  var dataSource: DS!
  
  override func viewDidLoad() {
    configureViewModel()
    configureDataSource()
    super.viewDidLoad()
  }
}

/// Use this `ViewController` if you don't need a `ViewModel` or even a `DataSource`.
class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
    configureUI()
    configureTexts()
    configureCollectionView()
    configureTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureNavigationBar()
  }
  
  
  // MARK: - Configurations
  
  /// Use this method to set up the view controller.
  func setUp() { }
  
  /// Use this method to configure the navigation controller.
  /// This method is called every time the view appear.
  ///
  /// Use `super.configureNavigationBar()` if you want to hide the back button string.
  func configureNavigationBar() {
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }
  
  /// Use this method to configure the graphic elements.
  func configureUI() { }
  
  /// Use this method to configure every text and localization of the view controller.
  func configureTexts() { }
  
  /// Use this method to configure the `collectionView` if needed.
  func configureCollectionView() { }
  
  /// Use this method to configure the `tableView` if needed.
  func configureTableView() { }
}
