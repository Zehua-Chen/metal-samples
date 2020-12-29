//
//  ModelRenderer.swift
//  SampleSkybox
//
//  Created by Zehua Chen on 12/25/20.
//

import Metal
import MetalKit
import simd

private var _vertices: [Float32] = [
  -0.7, -0.7,  0.7, 1,
   0.7, -0.7,  0.7, 1,
   0.7,  0.7,  0.7, 1,
  -0.7,  0.7,  0.7, 1,
  // back
  -0.7, -0.7, -0.7, 1,
   0.7, -0.7, -0.7, 1,
   0.7,  0.7, -0.7, 1,
  -0.7,  0.7, -0.7, 1,
]

private var _indices: [UInt16] = [
  0, 1, 2,
  2, 3, 0,
  // right
  1, 5, 6,
  6, 2, 1,
  // back
  7, 6, 5,
  5, 4, 7,
  // left
  4, 0, 3,
  3, 7, 4,
  // bottom
  4, 5, 1,
  1, 0, 4,
  // top
  3, 2, 6,
  6, 7, 3
]

enum _RendererError: Error {
  case noDevice
}

internal class _MonkeyRenderer {
  internal var assetManager: _AssetManager
  internal var settingsManager: _SettingsManager
  internal var library: MTLLibrary
  internal var device: MTLDevice
  fileprivate var _pipelineState: MTLRenderPipelineState
  fileprivate var _indexBuffer: MTLBuffer
  fileprivate var _vertexBuffer: MTLBuffer

  fileprivate var _transform: skybox_teapot_transform = .init(transform: matrix_identity_float4x4)
  fileprivate var _camera: skybox_camera = .init(
    view: matrix_identity_float4x4,
    projection: matrix_identity_float4x4)

  init(
    view: MTKView,
    library: MTLLibrary,
    assetManager: _AssetManager,
    settingsManager: _SettingsManager
  ) throws {
    guard let device = view.device else {
      throw _RendererError.noDevice
    }

    self.device = device

    self.assetManager = assetManager
    self.settingsManager = settingsManager
    self.library = library

    let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
    renderPipelineDescriptor.vertexFunction = library.makeFunction(name: "reflection_vertex")
    renderPipelineDescriptor.fragmentFunction = library.makeFunction(name: "reflection_fragment")
    renderPipelineDescriptor.colorAttachments[0].pixelFormat = view.colorPixelFormat
    renderPipelineDescriptor.depthAttachmentPixelFormat = view.depthStencilPixelFormat

    _pipelineState = try device.makeRenderPipelineState(
      descriptor: renderPipelineDescriptor)

    _vertexBuffer = device.makeBuffer(
      bytes: &_vertices,
      length: _vertices.count * MemoryLayout<Float32>.size,
      options: .storageModeManaged)!

    _indexBuffer = device.makeBuffer(
      bytes: &_indices,
      length: _indices.count * MemoryLayout<UInt16>.size,
      options: .storageModeManaged)!
  }

  func draw(using encoder: MTLRenderCommandEncoder, in viewport: MTLViewport) {
    // MARK: Update Settings
    _camera.view = settingsManager.view
    _camera.projection = settingsManager.projection

    // MARK: Render
    encoder.setRenderPipelineState(_pipelineState)

    encoder.setViewport(viewport)


//    guard let data = assetManager.monkeyMesh?.vertexBuffers[0] as? MTKMesh else {
//      return
//    }

//    encoder.setVertexBuffer(data.vertexBuffers[0].buffer, offset: 0, index: Int(SkyboxTeapotVertex))
//    encoder.drawIndexedPrimitives(type: .triangle, indexCount: 3, indexType: .uint32, indexBuffer: <#T##MTLBuffer#>, indexBufferOffset: _)

    encoder.setVertexBuffer(_vertexBuffer, offset: 0, index: Int(SkyboxTeapotVertexIndex))

    encoder.setVertexBytes(
      &_transform,
      length: MemoryLayout.size(ofValue: _transform),
      index: Int(SkyboxTeapotTransformIndex))

    encoder.setVertexBytes(
      &_camera,
      length: MemoryLayout.size(ofValue: _camera),
      index: Int(SkyboxCameraIndex))

    encoder.drawIndexedPrimitives(type: .triangle, indexCount: _indices.count, indexType: .uint16, indexBuffer: _indexBuffer, indexBufferOffset: 0)
  }
}
