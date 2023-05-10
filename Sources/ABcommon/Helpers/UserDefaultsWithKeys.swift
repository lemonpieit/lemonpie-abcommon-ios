//
//  UserDefaultsWithKeys.swift
//
//
//  Created by Francesco Leoni on 24/10/2020.
//

import Foundation

/// Extend and use this`enum` to define the `UserDefaults` keys.
public struct Keys { }

/// Use this enum to save an object in `UserDefaults`.
///
/// ### Warning
///
/// Do not modify this enum.
///
/// ### Usage
///
/// ```
/// // GET
/// SwiftDefaults.bool[Keys.hasShownOnboarding] // Optional(false)
///
/// // SET
/// SwiftDefaults.bool[Keys.hasShownOnboarding] = true
/// ```
public enum SwiftDefaults {
  static let string = SwiftDefaultsLogic<String>.self
  static let int = SwiftDefaultsLogic<Int>.self
  static let float = SwiftDefaultsLogic<Float>.self
  static let double = SwiftDefaultsLogic<Double>.self
  static let bool = SwiftDefaultsLogic<Bool>.self
  static let data = SwiftDefaultsLogic<Data>.self
  static let array = SwiftDefaultsLogic<Array<Any>>.self
  static let dictionary = SwiftDefaultsLogic<Dictionary<String, Any>>.self
  static let object = SwiftDefaultsLogic<Any>.self
}

/// A helper class that holds a static `UserDefaults`.
private struct SwiftDefaultsConstants {
  static let userDefaults = UserDefaults.standard
}

/// Do not use this class, use instead `SwiftDefaults` class.
internal class SwiftDefaultsLogic<Value> {
  
  /// Removes an object at a specified key.
  ///
  /// - Parameter key: The key to use.
  static func removeObject(forKey key: String) {
    SwiftDefaultsConstants.userDefaults.removeObject(forKey: key)
  }
  
  /// Get or set a `Value` for a `UserDefaultsKeys`.
  ///
  /// - Parameter key: The key to use.
  ///
  /// - Returns: `nil` if a retrieved object cannot be cast to `Value`.
  ///
  /// ### Usage
  ///
  /// ```
  /// let userDefaults = SwiftDefaultsLogic<Bool>()
  ///
  /// // GET
  /// userDefaults[.hasShownOnboarding] // Optional(false)
  ///
  /// // SET
  /// userDefaults[.hasShownOnboarding] = true
  /// ```
  ///
  static subscript(key: String) -> Value? {
    get {
      SwiftDefaultsConstants.userDefaults.object(forKey: key) as? Value
    }
    set {
      SwiftDefaultsConstants.userDefaults.setValue(newValue, forKey: key)
    }
  }
}
