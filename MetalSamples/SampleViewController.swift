//
//  SampleViewController.swift
//  MetalSamples
//
//  Created by Zehua Chen on 12/14/20.
//

import AppKit
import Combine
import SampleKit
import SwiftUI

class SampleViewController: NSViewController {

  fileprivate weak var _hostingController: NSHostingController<AnyView>!
  fileprivate weak var _appDelegate: AppDelegate!
  fileprivate var _cancellables: Set<AnyCancellable> = []
  fileprivate weak var _activeSample: Sample?

  override func viewDidLoad() {
    super.viewDidLoad()

    view.widthAnchor.constraint(greaterThanOrEqualToConstant: 450).isActive = true
    view.heightAnchor.constraint(greaterThanOrEqualToConstant: 400).isActive = true

    _appDelegate = (NSApplication.shared.delegate as! AppDelegate)
    _appDelegate.sample.sink { [unowned self] sample in
      if sample === _activeSample {
        return
      }

      view.window?.subtitle = sample?.name ?? ""

      let body = sample?.body ?? AnyView(Text("Sample"))
      _updateContent(body: body)

      _activeSample = sample
    }
    .store(in: &_cancellables)
  }

  fileprivate func _updateContent(body: AnyView) {
    for subview in view.subviews {
      subview.removeFromSuperview()
    }

    children = []

    // Create hosting view/view controller and add it as a child
    let hostingController = NSHostingController<AnyView>(rootView: body)
    addChild(hostingController)

    _hostingController = hostingController

    let hostingView = hostingController.view
    view.addSubview(hostingView)

    // Configure hostingView's constraints
    hostingView.translatesAutoresizingMaskIntoConstraints = false

    let safeArea = view.safeAreaLayoutGuide

    hostingView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
    hostingView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0).isActive = true
    hostingView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0).isActive = true
    hostingView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0).isActive = true
  }
}
