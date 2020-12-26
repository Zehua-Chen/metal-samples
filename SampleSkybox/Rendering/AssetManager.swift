//
//  AssetManager.swift
//  SampleSkybox
//
//  Created by Zehua Chen on 12/25/20.
//

import Metal
import MetalKit
import OSLog

internal class _AssetManager {
  internal var device: MTLDevice
  internal var meshBufferAllocator: MTKMeshBufferAllocator
  internal var logger: Logger
  internal var monkeyMesh: MDLMesh?

  init(device: MTLDevice, logger: Logger) {
    self.device = device
    self.logger = logger
    self.meshBufferAllocator = MTKMeshBufferAllocator(device: device)

    guard let modelURL = SampleSkybox._bundle.url(forResource: "Monkey", withExtension: "obj") else {
      logger.error("Failed to locate Monkey.obj (\(#file):\(#line))")
      return
    }

    let monkeyAsset = MDLAsset(
      url: modelURL, vertexDescriptor: nil, bufferAllocator: meshBufferAllocator)

    guard let monkeyMesh = monkeyAsset.object(at: 0) as? MDLMesh else {
      logger.error("Failed to obtain mesh (\(#file):\(#line))")
      return
    }

    self.monkeyMesh = monkeyMesh
  }
}
