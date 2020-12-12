//
//  Samples.swift
//  SampleKit
//
//  Created by Zehua Chen on 12/12/20.
//

import OSLog

/// Convenience class that loads samples
public class Samples {
  /// The bundle to load samples from
  public let bundle: Bundle

  /// The loaded samples
  public var samples: [Sample] = []

  /// Create a `Samples` instance from a bundle
  /// - Parameter bundle: the bundle
  public init(bundle: Bundle) {
    self.bundle = bundle
  }

  /// Load samples from a bundle.
  ///
  /// Calling this method would reset `.samples`
  /// - Parameter logger: the logger used to report errors
  /// - Throws: Any errors thrown by `FileManager.contentsOfDirectory(self, ...)`
  public func load(logger: Logger) throws {
    samples = []

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
