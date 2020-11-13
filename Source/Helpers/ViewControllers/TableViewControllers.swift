//
//  ViewControllers.swift
//
//  Created by Francesco Leoni on 30/10/2020.
//  Copyright © 2020 Francesco Leoni. All rights reserved.
//

import UIKit

/// Use this `ViewController` if you need a `ViewModel` without an internal `Delegate`.
open class BaseViewModelTVC<BVM: BaseViewModel>: TableViewController, HasBaseViewModel {
  
  open var viewModel: BVM!
  
  open override func viewDidLoad() {
    configureBaseViewModel()
    super.viewDidLoad()
  }
}

/// Use this `ViewController` if you need a `ViewModel` with an internal `Delegate`.
open class ViewModelTVC<VM: ViewModel>: TableViewController, HasViewModel {
  
  open var viewModel: VM!
  
  open override func viewDidLoad() {
    configureViewModel()
    super.viewDidLoad()
  }
}

/// Use this `ViewController` if you need a `DataSource`.
open class DataSourceTVC<DS: DataSource>: TableViewController, HasDataSource {
  
  open var dataSource: DS!
  
  open override func viewDidLoad() {
    configureDataSource()
    super.viewDidLoad()
  }
}

/// Use this `ViewController` if you need a `DataSource` and a `ViewModel` without an internal `Delegate`.
open class BaseViewModelDataSourceTVC<BVM: BaseViewModel, DS: DataSource>: TableViewController, HasBaseViewModel, HasDataSource {
  
  open var viewModel: BVM!
  open var dataSource: DS!
  
  open override func viewDidLoad() {
    configureBaseViewModel()
    configureDataSource()
    super.viewDidLoad()
  }
}

/// Use this `ViewController` if you need a `DataSource` and a `ViewModel` with an internal `Delegate`.
open class ViewModelDataSourceTVC<VM: ViewModel, DS: DataSource>: TableViewController, HasViewModel, HasDataSource {
  
  open var viewModel: VM!
  open var dataSource: DS!
  
  open override func viewDidLoad() {
    configureViewModel()
    configureDataSource()
    super.viewDidLoad()
  }
}

/// Use this `TableViewController` if you don't need a `ViewModel` or even a `DataSource`.
open class TableViewController: UITableViewController {
  
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
