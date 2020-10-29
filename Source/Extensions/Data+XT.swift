//
//  Data+XT.swift
//  ABcommon
//
//  Created by Francesco Leoni on 10/04/2020.
//

import Foundation

public extension Data {
  /// Prints JSON string in the console.
  func printJSON() {
    if let JSONString = String(data: self, encoding: .utf8) {
      print(JSONString)
    }
  }

  /// Converts string to JSON format.
  func toJSON() -> String? {
    return String(data: self, encoding: .utf8)
  }
}
