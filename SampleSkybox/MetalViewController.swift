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
  fileprivate var _library: MTLLibrary!
  fileprivate var _viewport: MTLViewport = MTLViewport()
  fileprivate var _queue: MTLCommandQueue!

  fileprivate var _assetManager: _AssetManager!
  fileprivate var _monkeyRenderer: _MonkeyRenderer!

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

    // MARK: Asset Loading
    do {
      _assetManager = _AssetManager(device: device, logger: _logger)
      _monkeyRenderer = try _MonkeyRenderer(
        view: mtkView, library: _library, assetManager: _assetManager)
    } catch {
      _logger.error("\(error.localizedDescription) (\(#file):\(#line))")
      return
    }
  }

  // MARK: - MTKViewDelegate Conformance

  func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    _viewport.height = Double(size.height)
    _viewport.width = Double(size.width)
  }

  func draw(in view: MTKView) {
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

    _monkeyRenderer.draw(using: renderCommandEncoder, in: _viewport)

    renderCommandEncoder.endEncoding()

    guard let drawable = view.currentDrawable else { fatalError("Failed to obtain drawablw") }

    commandBuffer.present(drawable)
    commandBuffer.commit()
  }
}
