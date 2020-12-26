//
//  SkyboxMetalViewController.swift
//  SampleSkybox
//
//  Created by Zehua Chen on 12/24/20.
//

import AppKit
import Metal
import MetalKit
import ModelIO

internal class _SkyboxMetalViewController: NSViewController, MTKViewDelegate {
  fileprivate var _device: MTLDevice!
  fileprivate var _mesh: MDLMesh!
  fileprivate var _meshBufferAllocator: MTKMeshBufferAllocator!

  override func viewDidLoad() {
    // MARK: View Configuration
    guard let mtkView = view as? MTKView else {
      fatalError("Root view is not MTKView")
    }

    guard let device = mtkView.preferredDevice else { fatalError("Failed to obtain device") }

    mtkView.delegate = self
    mtkView.device = device

    // MARK: Metal Configuration
    _meshBufferAllocator = MTKMeshBufferAllocator(device: device)
    let bundle = SampleSkybox._bundle

    // MARK: Asset Loading
    guard let modelURL = bundle.url(forResource: "Monkey", withExtension: "obj") else {
      fatalError("Failed to locate Monkey.obj")
    }

    let asset = MDLAsset(
      url: modelURL, vertexDescriptor: nil, bufferAllocator: _meshBufferAllocator)

    guard let mesh = asset.object(at: 0) as? MDLMesh else {
      fatalError("Failed to obtain mesh")
    }

    _mesh = mesh
  }

  // MARK: - MTKViewDelegate Conformance

  func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
  }

  func draw(in view: MTKView) {
    guard let device = view.device else { fatalError("Failed to obtain device") }
    guard let queue = device.makeCommandQueue() else {
      fatalError("Failed to create command queue")
    }
    guard let commandBuffer = queue.makeCommandBuffer() else {
      fatalError("Failed to create command buffer")
    }

    //    let renderPassDescriptor = MTLRenderPassDescriptor()

    guard let drawable = view.currentDrawable else { fatalError("Failed to obtain drawablw") }

    commandBuffer.present(drawable)
    commandBuffer.commit()

  }
}
