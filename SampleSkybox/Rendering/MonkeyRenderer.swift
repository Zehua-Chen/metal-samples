//
//  ModelRenderer.swift
//  SampleSkybox
//
//  Created by Zehua Chen on 12/25/20.
//

import Metal
import MetalKit

enum _RendererError: Error {
  case noDevice
}

internal class _MonkeyRenderer {
  internal var assetManager: _AssetManager
  internal var library: MTLLibrary
  internal var device: MTLDevice
  fileprivate var _pipelineState: MTLRenderPipelineState

  init(view: MTKView, library: MTLLibrary, assetManager: _AssetManager) throws {
    guard let device = view.device else {
      throw _RendererError.noDevice
    }

    self.device = device

    self.assetManager = assetManager
    self.library = library

    let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
    renderPipelineDescriptor.vertexFunction = library.makeFunction(name: "reflection_vertex")
    renderPipelineDescriptor.fragmentFunction = library.makeFunction(name: "reflection_fragment")
    renderPipelineDescriptor.colorAttachments[0].pixelFormat = view.colorPixelFormat

    _pipelineState = try device.makeRenderPipelineState(
      descriptor: renderPipelineDescriptor)
  }

  func draw(using encoder: MTLRenderCommandEncoder, in viewport: MTLViewport) {
    encoder.setRenderPipelineState(_pipelineState)

    encoder.setViewport(viewport)
    var numbers: [Float32] = [
      -1, -1, 0.1, 1,
      1, -1, 0.1, 1,
      0, 1, 0.1, 1
    ]

    encoder.setVertexBytes(&numbers, length: numbers.count * MemoryLayout<Float32>.size, index: Int(SkyboxTeapotVertex))
    encoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)
  }
}
