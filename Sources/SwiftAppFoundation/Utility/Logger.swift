//
//  Logger.swift
//  AppFoundation
//
//  Created by Andrew Aquino on 1/15/20.
//

import Foundation

public class Logger {
  public enum LogLevel: Int {
    case none
    case system
    case error
    case info

    public var stringValue: String {
      switch self {
      case .none: return "none"
      case .info: return "info"
      case .error: return "error"
      case .system: return "system"
      }
    }
  }
  private struct Log {
    let value: Any
    let logLevel: LogLevel
    let printTrace: Bool
    let function: String
    let file: String
    let line: Int
    
    var traceString: String? {
      printTrace ? "\(file):\(line) \(function)" : nil
    }
  }
  private var items: [Log] = []
  
  public init() {
  }
  
  private func canLog(logLevel: LogLevel) -> Bool {
    return envStringArray("allowable_log_levels").flatMap({ $0.contains(logLevel.stringValue) }) ?? false
      || envInt("log_level") ?? 0 >= logLevel.rawValue
  }
  
  public func enqueue(
    _ value: Any,
    logLevel: LogLevel = .info,
    printTrace: Bool = false,
    function: String = #function,
    file: String = #file,
    line: Int = #line
  ) {
    guard canLog(logLevel: logLevel) else { return }
    items.append(Log(
      value: value,
      logLevel: logLevel,
      printTrace: printTrace,
      function: function,
      file: file,
      line: line
    ))
  }
  
  public func flush() {
    for item in items {
      guard canLog(logLevel: item.logLevel) else { continue }
      item.traceString.flatMap({ print($0) })
      print(item.value)
    }
  }
  
  public func log(
    _ value: Any,
    logLevel: LogLevel = .info,
    function: String = #function,
    file: String = #file,
    line: Int = #line
  ) {
    self.enqueue(value, logLevel: logLevel, function: function, file: file, line: line)
  }
}

private let coreLogger = Logger()

public func Log(
  _ value: Any,
  _ logLevel: Logger.LogLevel = .info,
  function: String = #function,
  file: String = #file,
  line: Int = #line
) {
  coreLogger.log(
    value,
    logLevel: logLevel,
    function: function,
    file: file,
    line: line
  )
}
