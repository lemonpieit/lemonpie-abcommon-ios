//
//  Utility.swift
//  ConnectToWifi
//
//  Created by Luigi Aiello on 03/05/2019.
//  Copyright © 2019 Luigi Aiello. All rights reserved.
//

import Foundation
import NetworkExtension
import SystemConfiguration.CaptiveNetwork

// MARK: - Custom Struct

public struct NEHotspotCallback {
  var onSuccess: (_ value: Any?) -> Void
  var onError: (_ error: NEHotspotError) -> Void
}

public enum NEPlatform {
  static var isSimulator: Bool {
    return TARGET_OS_SIMULATOR != 0
  }
}

// MARK: - Custom Error

public enum NEHotspotError: Error {
  case usingSimulator
  case generic(error: Error)
  case unknown
}

public enum NEHotspotManager {
    
  // MARK: - Public Methods

  public static func simpleConnectionToWifi(ssid: String, password: String, isWEP: Bool, completionHandler: NEHotspotCallback?) {
    let configuration = NEHotspotConfiguration(ssid: ssid, passphrase: password, isWEP: isWEP)
    configuration.joinOnce = false

    apply(configuration: configuration, completionHandler)
  }

  public static func advanceConnectionToWifi(configuration: NEHotspotConfiguration, completionHandler: NEHotspotCallback?) {
    apply(configuration: configuration, completionHandler)
  }

  // MARK: - Internal method

  private static func apply(configuration: NEHotspotConfiguration, _ completionHandler: NEHotspotCallback?) {
    guard !NEPlatform.isSimulator else {
      completionHandler?.onError(NEHotspotError.usingSimulator)
      return
    }

    NEHotspotConfigurationManager.shared.apply(configuration) { error in
      if let error = error {
        if (error as NSError).code == 13 {
          completionHandler?.onSuccess(nil)
        } else {
          completionHandler?.onError(NEHotspotError.generic(error: error))
        }
      } else if let currentSSID = currentSSIDs().first, currentSSID == configuration.ssid {
        completionHandler?.onSuccess(nil)
      } else {
        completionHandler?.onError(NEHotspotError.unknown)
      }
    }
  }

  public static func remove(configurations ssid: String) {
    NEHotspotConfigurationManager.shared.removeConfiguration(forSSID: ssid)
  }

  // MARK: - Helpers

  public static func currentSSIDs() -> [String] {
    guard let interfaceNames = CNCopySupportedInterfaces() as? [String] else {
      return []
    }

    return interfaceNames.compactMap { name in
      guard let info = CNCopyCurrentNetworkInfo(name as CFString) as? [String: AnyObject] else {
        return nil
      }

      guard let ssid = info[kCNNetworkInfoKeySSID as String] as? String else {
        return nil
      }

      return ssid
    }
  }
}
