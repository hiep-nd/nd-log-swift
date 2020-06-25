//
//  NDLog_SwiftTests.swift
//  NDLog_SwiftTests
//
//  Created by Nguyen Duc Hiep on 6/25/20.
//  Copyright © 2020 Nguyen Duc Hiep. All rights reserved.
//

import XCTest

@testable import NDLog_Swift

class NDLog_SwiftTests: XCTestCase {
  func test_Config() throws {
    XCTAssertTrue(nd_configureLog(paras: [.level: NDLogLevel.warning]))
    XCTAssertEqual(NDLogLevel.warning, definedLogLevel())
  }

  func test_Config_invalid() throws {
    if _isDebugAssertConfiguration() {
    } else {
      XCTAssertFalse(nd_configureLog(paras: [.level: "Error"]))
      XCTAssertEqual(NDLogLevel.error, definedLogLevel())
    }
  }

  func test_Assert() throws {
    nd_assert(true)
  }

  func test_LogError() throws {
    nd_log(error: "Error message")
  }

  func test_LogWarning() throws {
    nd_log(warning: "Warning message")
  }

  func test_LogInfo() throws {
    nd_log(info: "Info message")
  }

  func test_LogDebug() throws {
    nd_log(info: "Debug message")
  }

  func test_LogVerbose() throws {
    nd_log(verbose: "Verbose message")
  }

  func test_LogTagError() {
    nd_log(error: "Error message", tag: "mylog")
  }
}
