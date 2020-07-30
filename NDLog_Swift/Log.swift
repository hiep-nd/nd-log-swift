//
//  NDLog.swift
//  NDLog
//
//  Created by Nguyen Duc Hiep on 3/27/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

@discardableResult
public func nd_configureLog(paras: [NDLogParameterKey: Any]) -> Bool {
  return __NDLogConfigureWithParas(
    paras.reduce(
      into: [:],
      {
        switch $1.key {
        case .level:
          $0[$1.key] = ($1.value is NDLogLevel)
            ? ($1.value as! NDLogLevel).rawValue : $1.value
        default:
          $0[$1.key] = $1.value
        }
      }))
}

@discardableResult
public func nd_configureLog(name: String = "NDLog") -> Bool {
  return __NDLogConfigureWithName(name)
}

@inlinable
public func nd_log(
  error: @autoclosure () -> String,
  function: StaticString = #function,
  file: StaticString = #file,
  line: UInt = #line,
  tag: Any? = nil
) {
  nd_log(
    severity: .error, message: error(), function: function, file: file,
    line: line, tag: tag)
}

@inlinable
public func nd_log(
  warning: @autoclosure () -> String,
  function: StaticString = #function,
  file: StaticString = #file,
  line: UInt = #line,
  tag: Any? = nil
) {
  nd_log(
    severity: .warning, message: warning(), function: function, file: file,
    line: line, tag: tag)
}

@inlinable
public func nd_log(
  info: @autoclosure () -> String,
  function: StaticString = #function,
  file: StaticString = #file,
  line: UInt = #line,
  tag: Any? = nil
) {
  nd_log(
    severity: .info, message: info(), function: function, file: file,
    line: line, tag: tag)
}

@inlinable
public func nd_log(
  debug: @autoclosure () -> String,
  function: StaticString = #function,
  file: StaticString = #file,
  line: UInt = #line,
  tag: Any? = nil
) {
  nd_log(
    severity: .debug, message: debug(), function: function, file: file,
    line: line, tag: tag)
}

@inlinable
public func nd_log(
  verbose: @autoclosure () -> String,
  function: StaticString = #function,
  file: StaticString = #file,
  line: UInt = #line,
  tag: Any? = nil
) {
  nd_log(
    severity: .verbose, message: verbose(), function: function, file: file,
    line: line, tag: tag)
}

@inlinable
public func nd_log(
  severity: NDLogSeverity,
  message: @autoclosure () -> String,
  function: StaticString = #function,
  file: StaticString = #file,
  line: UInt = #line,
  tag: Any? = nil
) {
  if (definedLogLevel().rawValue & severity.rawValue) != 0 {
    __NDLogMessage(
      severity, message(), String(describing: file),
      String(describing: function), line, tag)
  }
}

@inlinable
public func nd_assert(
  _ condition: @autoclosure () -> Bool,
  _ message: @autoclosure () -> String = String(),
  function: StaticString = #function,
  file: StaticString = #file,
  line: UInt = #line,
  tag: Any? = nil
) {
  if !condition() {
    var logMesg: String? = nil
    func getLogMesg() -> String {
      if let logMesg = logMesg {
        return logMesg
      }
      let mesg = message()
      logMesg = mesg.count > 0
        ? "Failure assertion. \(mesg)" : "Failure assertion."
      return logMesg!
    }

    nd_log(
      error: getLogMesg(), function: function, file: file, line: line, tag: tag)
    Swift.assertionFailure(getLogMesg(), file: file, line: line)
  }
}

@inlinable
public func nd_assertionFailure(
  _ message: @autoclosure () -> String = String(),
  function: StaticString = #function,
  file: StaticString = #file,
  line: UInt = #line,
  tag: Any? = nil
) {
  nd_assert(
    false, message(), function: function, file: file, line: line, tag: tag)
}
