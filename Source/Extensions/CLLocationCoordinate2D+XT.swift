//
//  CLLocationCoordinate2D+XT.swift
//  BikeApp
//
//  Created by Francesco Colleoni on 25/01/17.
//  Copyright © 2017 Mindtek srl. All rights reserved.
//

import CoreLocation
import Foundation

public extension CLLocationCoordinate2D {
  /// Returns the distance between two `CLLocation`.
  /// - Parameter from: The starting location.
  func distance(from: CLLocationCoordinate2D) -> CLLocationDistance {
    let here = CLLocation(latitude: latitude, longitude: longitude)
    let there = CLLocation(latitude: from.latitude, longitude: from.longitude)

    return here.distance(from: there)
  }

  /// Returns a `Bool` indication whether the coordinates fulfill the precision parameter..
  /// - Parameters:
  ///   - to: The location.
  ///   - precision: The level of precision.
  func equals(to: CLLocationCoordinate2D, withPrecision precision: Double = .ulpOfOne) -> Bool {
    return distance(from: to) < precision
  }
}
