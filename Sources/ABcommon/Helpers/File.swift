//
//  File.swift
//  
//
//  Created by Francesco Leoni on 13/12/22.
//

import Foundation

public struct File {
  
  var filename: String
  var type: String
  
  public init(_ filename: String, type: String) {
    self.filename = filename
    self.type = type
  }
  
  public func read() -> Data? {
    guard let path = Bundle.main.path(forResource: filename, ofType: type) else {
      Logger.print(type: .fatal, "No file named \(filename).\(type) found.")
      return nil
    }
    
    let url = URL(fileURLWithPath: path)
    
    do {
      return try Data(contentsOf: url)
    } catch let error {
      Logger.error(error)
      return nil
    }
  }
  
  public func read<Object: Decodable>(_ object: Object.Type) -> Object? {
    do {
      guard let data = read() else {
        Logger.print(type: .error, "Data for file \(filename).\(type) are nil.")
        return nil
      }
      
      return try JSONDecoder().decode(object, from: data)
    } catch {
      Logger.error(error)
      return nil
    }
  }
}
