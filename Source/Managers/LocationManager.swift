//
//  HomeLocationManager.swift
//  DiCEhome
//
//  Created by Francesco Leoni on 14/05/2020.
//  Copyright © 2020 DiCEworld S.r.l. All rights reserved.
//

import CoreLocation
import UIKit

public protocol LocationManagerDelegate: class {
  func authorizationStatus(_ status: Bool)
}

public class LocationManager: NSObject, CLLocationManagerDelegate {
  private static var privateShared: LocationManager?
  weak var delegate: LocationManagerDelegate?
  var locationManager = CLLocationManager()

  // MARK: - Auth

  public func getLocationAuth(always: Bool) {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters

    if always {
      locationManager.requestAlwaysAuthorization()
    } else {
      locationManager.requestWhenInUseAuthorization()
    }

    locationManager.startUpdatingLocation()
  }

  // MARK: - CLLocationManagerDelegate

  public func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedWhenInUse:
      locationManager.requestLocation()
      getLocationAuth(always: true)
      delegate?.authorizationStatus(true)
    case .authorizedAlways:
      locationManager.requestLocation()
    case .denied, .restricted:
      delegate?.authorizationStatus(false)
    case .notDetermined:
      print("Location permission not determined")
    default: break
    }
  }

  public func checkLocationEnabled() {
    if CLLocationManager.locationServicesEnabled() {
      switch CLLocationManager.authorizationStatus() {
      case .authorizedAlways, .authorizedWhenInUse:
        delegate?.authorizationStatus(true)
      case .restricted, .denied:
        delegate?.authorizationStatus(false)
      case .notDetermined:
        print("Location permission not determined")
      default: break
      }
    } else {
      delegate?.authorizationStatus(false)
    }
  }

  // Called by startUpdatingLocation() and requestLocation()
  public func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else { return }
    print(location.coordinate)
  }

  public func locationManager(_: CLLocationManager, didFailWithError error: Error) {
    print(error.localizedDescription)
  }

  // MARK: - Singleton helpers

  public class func shared() -> LocationManager {
    guard let shared = privateShared else {
      privateShared = LocationManager()
      return privateShared!
    }
    return shared
  }

  public class func destroySingleton() {
    privateShared = nil
  }
}
