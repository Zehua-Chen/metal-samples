//
//  MetalSamplesApp.swift
//  MetalSamples
//
//  Created by Zehua Chen on 12/12/20.
//

import Foundation
import OSLog
import SampleKit
import SwiftUI

@main
struct MetalSamplesApp: App {
  /// A list of samples contained in the application bundle
  var samples: [SKSample]

  init() {
    let logger = Logger.sampleSystem(category: "Loading")
    
    do {
      samples = try SKSamples.load(from: Bundle.main, logger: logger)
    } catch {
      samples = []
      logger.error("Error: \(error.localizedDescription)")
    }
  }

  var body: some Scene {
    WindowGroup {
      Samples(samples: samples)
    }
    .windowToolbarStyle(UnifiedWindowToolbarStyle())
  }
}
