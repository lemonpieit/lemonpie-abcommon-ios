//
//  Bundle+XT.swift
//  BikeApp
//
//  Created by Luigi Aiello on 23/09/17.
//  Copyright © 2017 Mindtek srl. All rights reserved.
//

import Foundation

public extension Bundle {
  /// The release or version number of the bundle.
  var bundleShortVersionNumber: String? {
    return infoDictionary?["CFBundleShortVersionString"] as? String
  }

  /// The version of the build that identifies an iteration of the bundle.
  var bundleVersionNumber: String? {
    return infoDictionary?["CFBundleVersion"] as? String
  }

  /// The user-visible name for the bundle, used by Siri and visible on the iOS Home screen..
  var bundleDisplayName: String? {
    return infoDictionary?["CFBundleDisplayName"] as? String
  }
}
