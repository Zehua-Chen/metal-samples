//
//  Samples.swift
//  SampleKit
//
//  Created by Zehua Chen on 12/12/20.
//

import OSLog

/// Convenience class for sample operations
public class Samples {
  /// Load samples from a bundle.
  /// - Parameters:
  ///   - bundle: the bundle to load samples from
  ///   - logger: the logger used to report errors
  /// - Throws: Any errors thrown by `FileManager.contentsOfDirectory(self, ...)`
  /// - Returns: An array of samples
  public static func load(from bundle: Bundle, logger: Logger) throws -> [Sample] {
    var samples: [Sample] = []

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

    return samples
  }
}
