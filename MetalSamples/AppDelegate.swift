//
//  AppDelegate.swift
//  MetalSamples
//
//  Created by Zehua Chen on 12/14/20.
//

import AppKit
import Combine
import OSLog
import SampleKit

@main
class AppDelegate: NSObject, NSApplicationDelegate {
  var samplesFilter: SampleFilter = SampleFilter()
  var sample: CurrentValueSubject<Sample?, Never> = CurrentValueSubject<Sample?, Never>(nil)

  lazy var samples: [Sample] = {
    let logger = Logger.sampleSystem(category: "Loading")

    do {
      return try Samples.load(from: .main, logger: logger)
    } catch {
      logger.error("\(error.localizedDescription)")
    }

    return []
  }()

  func applicationDidFinishLaunching(_ notification: Notification) {
  }

  func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
}
