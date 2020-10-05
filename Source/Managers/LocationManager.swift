//
//  HomeLocationManager.swift
//  DiCEhome
//
//  Created by Francesco Leoni on 14/05/2020.
//  Copyright © 2020 DiCEworld S.r.l. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationManagerDelegate: class {
    func authorizationStatus(_ status: Bool)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private static var privateShared: LocationManager?
    weak var delegate: LocationManagerDelegate?
    var locationManager = CLLocationManager()

    // MARK: - Auth
    func getLocationAuth(always: Bool) {
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
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
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
    
    func checkLocationEnabled() {
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
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        print(location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // MARK: - Singleton helpers
    class func shared() -> LocationManager {
        guard let shared = privateShared else {
            privateShared = LocationManager()
            return privateShared!
        }
        return shared
    }
    
    class func destroySingleton() {
        privateShared = nil
    }
}
