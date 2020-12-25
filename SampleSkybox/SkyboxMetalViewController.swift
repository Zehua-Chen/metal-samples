//
//  SkyboxMetalViewController.swift
//  SampleSkybox
//
//  Created by Zehua Chen on 12/24/20.
//

import AppKit
import ModelIO
import Metal
import MetalKit

internal class _SkyboxMetalViewController: NSViewController, MTKViewDelegate {
  fileprivate var _device: MTLDevice!
  fileprivate var _mesh: MDLMesh!

  override func viewDidLoad() {
    // MARK: View Configuration
    guard let mtkView = view as? MTKView else {
      fatalError("Root view is not MTKView")
    }

    mtkView.delegate = self

    // MARK: Metal Configuration
    let bundle = SampleSkybox._bundle

    _device = MTLCreateSystemDefaultDevice()

    // MARK: Asset Loading
    guard let modelURL = bundle.url(forResource: "Monkey", withExtension: "obj") else {
      fatalError("Failed to locate Monkey.obj")
    }

    let bufferAllocator = MTKMeshBufferAllocator(device: _device)
    let asset = MDLAsset(url: modelURL, vertexDescriptor: nil, bufferAllocator: bufferAllocator)

    guard let mesh = asset.object(at: 0) as? MDLMesh else {
      fatalError("Failed to obtain mesh")
    }

    _mesh = mesh
  }

  // MARK: - MTKViewDelegate Conformance

  func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
  }

  func draw(in view: MTKView) {
  }
}
