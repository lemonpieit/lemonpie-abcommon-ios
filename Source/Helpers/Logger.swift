//
//  Logger.swift
//
//  Created by Francesco Leoni on 10/10/2020.
//  Copyright © 2020 All rights reserved.
//

import Foundation
import os

/// Defines the basic function of a `Logger`.
public protocol Logging {
  
  /// Prints to the `Debug area` and to the `Console` a custom message.
  ///
  /// - Parameters:
  ///   - type: The log level.
  ///   - message: The message to be printed.
  ///   - line: The file line that called this function.
  ///   - funcName: The name of the function in which this method has been called.
  ///   - filePath: The name of the file in which this method has been called.
  static func print(type: Logger.Level, _ message: Any, line: UInt, funcName: String, filePath: String)
  
  /// Prints to the `Debug area` and to the `Console` a custom message.
  /// This function allows you to choose a custom log object.
  ///
  /// - Parameters:
  ///   - type: The log level.
  ///   - log: The `OSLog` that defines the `Subsystem` and the `Category` in the `Console`.
  ///   - message: The message to be printed.
  ///   - line: The file line that called this function.
  ///   - funcName: The name of the function in which this method has been called.
  ///   - filePath: The name of the file in which this method has been called.
  static func osLog(type: Logger.Level, log: OSLog, _ message: Any, line: UInt, funcName: String, filePath: String)
  
  /// Prints to the `Debug area` and to the `Console` the localizedDescription of an error.
  ///
  /// - Parameters:
  ///   - error: The error to print.
  ///   - line: The file line that called this function.
  ///   - funcName: The name of the function in which this method has been called.
  ///   - filePath: The name of the file in which this method has been called.
  static func printLocalized(_ error: Error, line: UInt, funcName: String, filePath: String)
  
  /// Prints only to the `Debug area` a custom message.
  ///
  /// - Parameters:
  ///   - type: The log level.
  ///   - message: The message to be printed.
  ///   - line: The file line that called this function.
  ///   - funcName: The name of the function in which this method has been called.
  ///   - filePath: The name of the file in which this method has been called.
  @available(*, deprecated, message: "Use print(type:_:line:funcName:filePath:) instead")
  static func printInDebugger(type: Logger.Level, _ message: Any, line: UInt, funcName: String, filePath: String)
}

public extension Logging {
  
  /// Prints an `Info` message to the `Debug area` and to the `Console`.
  ///
  /// - Parameters:
  ///   - message: The message to be printed.
  ///   - line: The file line that called this function.
  ///   - funcName: The name of the function in which this method has been called.
  ///   - filePath: The name of the file in which this method has been called.
  static func info(_ message: Any, line: UInt = #line, funcName: String = #function, filePath: String = #file) {
    print(type: .info, message, line: line, funcName: funcName, filePath: filePath)
  }
  
  /// Prints a `Debug` message to the `Debug area` and to the `Console`.
  ///
  /// - Parameters:
  ///   - message: The message to be printed.
  ///   - line: The file line that called this function.
  ///   - funcName: The name of the function in which this method has been called.
  ///   - filePath: The name of the file in which this method has been called.
  static func debug(_ message: Any, line: UInt = #line, funcName: String = #function, filePath: String = #file) {
    print(type: .debug, message, line: line, funcName: funcName, filePath: filePath)
  }
  
  /// Prints an `Api` message to the `Debug area` and to the `Console`.
  ///
  /// - Parameters:
  ///   - message: The message to be printed.
  ///   - line: The file line that called this function.
  ///   - funcName: The name of the function in which this method has been called.
  ///   - filePath: The name of the file in which this method has been called.
  static func api(_ message: Any, line: UInt = #line, funcName: String = #function, filePath: String = #file) {
    print(type: .api, message, line: line, funcName: funcName, filePath: filePath)
  }
  
  /// Prints an `Event` message to the `Debug area` and to the `Console`.
  ///
  /// - Parameters:
  ///   - message: The message to be printed.
  ///   - line: The file line that called this function.
  ///   - funcName: The name of the function in which this method has been called.
  ///   - filePath: The name of the file in which this method has been called.
  static func event(_ message: Any, line: UInt = #line, funcName: String = #function, filePath: String = #file) {
    print(type: .event, message, line: line, funcName: funcName, filePath: filePath)
  }
  
  /// Prints a `Notification` message to the `Debug area` and to the `Console`.
  ///
  /// - Parameters:
  ///   - message: The message to be printed.
  ///   - line: The file line that called this function.
  ///   - funcName: The name of the function in which this method has been called.
  ///   - filePath: The name of the file in which this method has been called.
  static func notification(_ message: Any, line: UInt = #line, funcName: String = #function, filePath: String = #file) {
    print(type: .notification, message, line: line, funcName: funcName, filePath: filePath)
  }
  
  /// Prints a `Warning` message to the `Debug area` and to the `Console`.
  ///
  /// - Parameters:
  ///   - message: The message to be printed.
  ///   - line: The file line that called this function.
  ///   - funcName: The name of the function in which this method has been called.
  ///   - filePath: The name of the file in which this method has been called.
  static func warning(_ message: Any, line: UInt = #line, funcName: String = #function, filePath: String = #file) {
    print(type: .warning, message, line: line, funcName: funcName, filePath: filePath)
  }
  
  /// Prints an `Error` message to the `Debug area` and to the `Console`.
  ///
  /// - Parameters:
  ///   - message: The message to be printed.
  ///   - line: The file line that called this function.
  ///   - funcName: The name of the function in which this method has been called.
  ///   - filePath: The name of the file in which this method has been called.
  static func error(_ message: Any, line: UInt = #line, funcName: String = #function, filePath: String = #file) {
    print(type: .error, message, line: line, funcName: funcName, filePath: filePath)
  }
  
  /// Prints a `Fatal error` message to the `Debug area` and to the `Console`.
  ///
  /// - Parameters:
  ///   - message: The message to be printed.
  ///   - line: The file line that called this function.
  ///   - funcName: The name of the function in which this method has been called.
  ///   - filePath: The name of the file in which this method has been called.
  static func fatal(_ message: Any, line: UInt = #line, funcName: String = #function, filePath: StaticString = #file) {
    print(type: .fatal, message, line: line, funcName: funcName, filePath: "\(filePath)")
    Swift.fatalError("\(message)", file: filePath, line: line)
  }
}

public class Logger: Logging {
  
  public enum Level: String {
    case info = "INFO ⚪️"
    case debug = "DEBUG 🐛"
    case api = "API 🐝"
    case event = "EVENT 🎬"
    case notification = "NOTIFICATION 📦"
    case warning = "WARNING ⚠️"
    case error = "ERROR ⛔️"
    case fatal = "FATAL 😵"
  }
  
  // MARK: - Generic
  
  public static func print(type: Level, _ message: Any, line: UInt = #line, funcName: String = #function, filePath: String = #file) {
    //    #if DEVELOPMENT || STAGING
    let osMessage = "\(type.rawValue) [\(sourceFileName(filePath: filePath)).\(funcName)] line \(line) -> \(message)"
    os_log("%{public}@", log: OSLog.from(loggerLevel: type), type: OSLogType.from(loggerLevel: type), osMessage as NSString)
    //    #endif
  }
  
  public static func osLog(type: Level, log: OSLog, _ message: Any, line: UInt = #line, funcName: String = #function, filePath: String = #file) {
    //    #if DEVELOPMENT || STAGING
    let osMessage = "\(type.rawValue) [\(sourceFileName(filePath: filePath)).\(funcName)] line \(line) -> \(message)"
    os_log("%{public}@", log: log, type: OSLogType.from(loggerLevel: type), osMessage as NSString)
    //    #endif
  }
  
  public static func printLocalized(_ error: Error, line: UInt = #line, funcName: String = #function, filePath: String = #file) {
    print(type: .error, error.localizedDescription, line: line, funcName: funcName, filePath: filePath)
  }
}

extension Logger {
  private static func sourceFileName(filePath: String) -> String {
    let components = filePath.components(separatedBy: "/")
    let filename = components.isEmpty ? "" : (components.last ?? "")
    let filenameComponents = filename.components(separatedBy: ".")
    return filenameComponents.first ?? ""
  }
}

extension Logger {
  @available(*, deprecated, message: "Use print(type:_:line:funcName:filePath:) instead")
  public static func printInDebugger(type: Level, _ message: Any, line: UInt = #line, funcName: String = #function, filePath: String = #file) {
    let messageComp = "\(Date()) - \(type.rawValue) [\(sourceFileName(filePath: filePath)).\(funcName)] line \(line) -> \(message)"
    print(messageComp)
  }
  
  @available(*, deprecated)
  private static func print(_ message: Any) {
    Swift.print(message)
  }
}

public extension OSLog {
  private static var subsystem = Bundle.main.bundleIdentifier!
  
  static let debug = OSLog(subsystem: subsystem, category: "debug")
  static let general = OSLog(subsystem: subsystem, category: "general")
  static let networking = OSLog(subsystem: subsystem, category: "networking")
  static let notifications = OSLog(subsystem: subsystem, category: "notifications")
  
  static func from(loggerLevel: Logger.Level) -> OSLog {
    switch loggerLevel {
    case .info, .event, .warning, .error, .fatal:
      return .general
    case .debug:
      return .debug
    case .api:
      return .networking
    case .notification:
      return .notifications
    }
  }
}

public extension OSLogType {
  static func from(loggerLevel: Logger.Level) -> Self {
    switch loggerLevel {
    case .debug:
      return .default
    case .info, .notification, .api, .event:
      return .info
    case .warning, .error:
      return .error
    case .fatal:
      return .fault
    }
  }
}
