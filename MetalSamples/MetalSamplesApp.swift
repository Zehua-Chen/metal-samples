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
  var samples: Samples

  init() {
    samples = Samples(bundle: Bundle.main)
    let logger = Logger.sampleSystem(category: "Loading")

    do {
      try samples.load(logger: logger)
    } catch {
      logger.error("Error: \(error.localizedDescription)")
    }
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
