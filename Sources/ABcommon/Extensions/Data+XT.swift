//
//  Data+XT.swift
//  ABcommon
//
//  Created by Francesco Leoni on 10/04/2020.
//

import Foundation

public extension Data {
  
  var prettyPrintedJSONString: NSString? {
    guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
          let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
          let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
    
    return prettyPrintedString
  }
  
  /// Converts string to JSON format.
  var toJSON: String? {
    String(data: self, encoding: .utf8)
  }
  
  /// Prints JSON string in the console.
  func printJSON() {
    if let JSONString = String(data: self, encoding: .utf8) {
      print(JSONString)
    }
  }
}
