//
//  SampleSkyboxMetalView.swift
//  SampleSkybox
//
//  Created by Zehua Chen on 12/12/20.
//
import Cocoa
import SwiftUI

internal class _SkyboxMetalViewController: NSViewController {
  override func viewDidLoad() {
    view.wantsLayer = true
    view.layer?.backgroundColor = .white
  }
}

internal struct _SkyboxMetalView: NSViewControllerRepresentable {
  typealias NSViewControllerType = _SkyboxMetalViewController

  func makeNSViewController(context: Context) -> _SkyboxMetalViewController {
    let bundle = Bundle(for: _SkyboxMetalViewController.self)
    let storyboard = NSStoryboard(name: "Storyboard", bundle: bundle)

    return storyboard.instantiateInitialController() as! _SkyboxMetalViewController
  }

  func updateNSViewController(_ nsViewController: _SkyboxMetalViewController, context: Context) {
  }
}

//struct SampleSkyboxMetalView_Previews: PreviewProvider {
//    static var previews: some View {
//        SampleSkyboxMetalView()
//    }
//}
