//
//  SampleSkyboxMetalView.swift
//  SampleSkybox
//
//  Created by Zehua Chen on 12/12/20.
//
import Cocoa
import SwiftUI

internal struct _MetalView: NSViewControllerRepresentable {
  typealias NSViewControllerType = _MetalViewController

  var rotationY: Float32

  func makeNSViewController(context: Context) -> _MetalViewController {
    let bundle = Bundle(for: _MetalViewController.self)
    let storyboard = NSStoryboard(name: "Storyboard", bundle: bundle)

    return storyboard.instantiateInitialController() as! _MetalViewController
  }

  func updateNSViewController(_ nsViewController: _MetalViewController, context: Context) {
    nsViewController.rotationY = rotationY
  }
}

//struct SampleSkyboxMetalView_Previews: PreviewProvider {
//    static var previews: some View {
//        SampleSkyboxMetalView()
//    }
//}
