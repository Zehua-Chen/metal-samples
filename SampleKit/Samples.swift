//
//  Samples.swift
//  SampleKit
//
//  Created by Zehua Chen on 12/12/20.
//

import OSLog

public class Samples {
  public let bundle: Bundle
  public var samples: [Sample] = []

  public init(bundle: Bundle) {
    self.bundle = bundle
  }

  public func load(logger: Logger) throws {
    let fileManager = FileManager.default

    guard let plugInsURL = bundle.builtInPlugInsURL else {
      logger.fault("Unable to obtain plug-ins path (\(#file):\(#line))")
      fatalError()
    }

    let urls = try fileManager.contentsOfDirectory(
      at: plugInsURL, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])

    for url in urls {
      guard let bundle = Bundle(url: url) else {
        logger.warning("Failed to initialize bundle at \(url.absoluteString) (\(#file):\(#line))")
        continue
      }

      guard let principalClass = bundle.principalClass as? Sample.Type else {
        logger.warning(
          "Failed to obtain principal class of bundle at \(url.absoluteString) (\(#file):\(#line))")
        continue
      }

      samples.append(principalClass.init())
    }
  }
}
