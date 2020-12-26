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
import SampleKit
import OSLog

internal class _MetalViewController: NSViewController, MTKViewDelegate {
  fileprivate var _logger: Logger = Logger.sample(category: "Skybox")
  fileprivate var _device: MTLDevice!
  fileprivate var _mesh: MDLMesh!
  fileprivate var _meshBufferAllocator: MTKMeshBufferAllocator!
  fileprivate var _renderPipelineState: MTLRenderPipelineState!
  fileprivate var _library: MTLLibrary!
  fileprivate var _viewport: MTLViewport = MTLViewport()
  fileprivate var _queue: MTLCommandQueue!

  override func viewDidLoad() {
    // MARK: View Configuration
    guard let mtkView = view as? MTKView else {
      _logger.error("Root view is not MTKView (\(#file):\(#line))")
      return
    }

    guard let device = mtkView.preferredDevice else {
      _logger.error("Failed to obtain device (\(#file):\(#line))")
      return
    }

    mtkView.delegate = self
    mtkView.device = device

    // MARK: Metal Configuration
    _queue = device.makeCommandQueue()

    do {
      _library = try device.makeDefaultLibrary(bundle: SampleSkybox._bundle)
    } catch {
      _logger.error("Failed to create library (\(#file):\(#line))")
      return
    }

    do {
      let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
      renderPipelineDescriptor.vertexFunction = _library.makeFunction(name: "reflection_vertex")
      renderPipelineDescriptor.fragmentFunction = _library.makeFunction(name: "reflection_fragment")
      renderPipelineDescriptor.colorAttachments[0].pixelFormat = mtkView.colorPixelFormat

      _renderPipelineState = try device.makeRenderPipelineState(
        descriptor: renderPipelineDescriptor)
    } catch {
      _logger.error("Failed to create render pipeline state (\(#file):\(#line))")
      return
    }

    // MARK: Asset Loading
    let bundle = SampleSkybox._bundle

    _meshBufferAllocator = MTKMeshBufferAllocator(device: device)

    guard let modelURL = bundle.url(forResource: "Monkey", withExtension: "obj") else {
      _logger.error("Failed to locate Monkey.obj (\(#file):\(#line))")
      return
    }

    let vertexDescriptor = MDLVertexDescriptor()
    vertexDescriptor.addOrReplaceAttribute(
      MDLVertexAttribute(name: "position", format: .float4, offset: 0, bufferIndex: 0))

    let asset = MDLAsset(
      url: modelURL, vertexDescriptor: vertexDescriptor, bufferAllocator: _meshBufferAllocator)

    guard let mesh = asset.object(at: 0) as? MDLMesh else {
      _logger.error("Failed to obtain mesh (\(#file):\(#line))")
      return
    }

    _mesh = mesh
  }

  // MARK: - MTKViewDelegate Conformance

  func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    _viewport.height = Double(size.height)
    _viewport.width = Double(size.width)
  }

  func draw(in view: MTKView) {
//    guard let device = view.device else { fatalError("Failed to obtain device") }

    guard let commandBuffer = _queue.makeCommandBuffer() else {
      _logger.error("Failed to create command buffer (\(#file):\(#line))")
      return
    }

    guard let renderPassDescriptor = view.currentRenderPassDescriptor else {
      _logger.error("Failed to obtain current render pass descriptor (\(#file):\(#line))")
      return
    }

    guard
      let renderCommandEncoder = commandBuffer.makeRenderCommandEncoder(
        descriptor: renderPassDescriptor)
    else {
      _logger.error("Failed to create render pass encoder (\(#file):\(#line))")
      return
    }

    renderCommandEncoder.label = "TeapotRenderEncoder"
    renderCommandEncoder.setRenderPipelineState(_renderPipelineState)

    _draw(with: renderCommandEncoder)

    renderCommandEncoder.endEncoding()

    guard let drawable = view.currentDrawable else { fatalError("Failed to obtain drawablw") }

    commandBuffer.present(drawable)
    commandBuffer.commit()
  }

  fileprivate func _draw(with encoder: MTLRenderCommandEncoder) {
    encoder.setViewport(_viewport)
//    guard let vertexBuffer = _mesh.vertexBuffers[0] as? MTKMeshBuffer else {
//      _logger.error("Failed to obtain mesh buffer (\(#file):\(#line))")
//      return
//    }
//
//    encoder.setVertexBuffer(vertexBuffer.buffer, offset: 0, index: Int(SkyboxTeapotVertex))
    var numbers: [Float32] = [
      -1, -1, 0.1, 1,
      1, -1, 0.1, 1,
      0, 1, 0.1, 1
    ]

    encoder.setVertexBytes(&numbers, length: numbers.count * MemoryLayout<Float32>.size, index: Int(SkyboxTeapotVertex))
    encoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)
  }
}
