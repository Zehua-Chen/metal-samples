//
//  Logger+Loggers.swift
//  SampleKit
//
//  Created by Zehua Chen on 12/12/20.
//

import OSLog

extension Logger {
  fileprivate static let _identifier: String = Bundle.main.bundleIdentifier ?? "MetalSamples"

  public static func sampleSystem(for category: String) -> Logger {
    return .init(subsystem: "\(_identifier).SampleSystem", category: category)
  }

  public static func sample(for category: String) -> Logger {
    return .init(subsystem: "\(_identifier).Sample", category: category)
  }
}
