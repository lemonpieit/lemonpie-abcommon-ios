//
//  AppDelegate.swift
//  ABcommon
//
//  Created by Francesco Leoni on 03/18/2020.
//  Copyright (c) 2020 Francesco Leoni. All rights reserved.
//

import UIKit
import ABcommon

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

      var app = Appearance()
//      app.navigationBar.barTintColor = .green
//      app.navigationBar.tintColor = .white
//      app.navigationBar.backgroundColor = .black
      Appearance.setDefaultAppearance(to: app)
      Appearance.setShadowVisibility(.onlyIfCanScroll)
      return true
    }

}

