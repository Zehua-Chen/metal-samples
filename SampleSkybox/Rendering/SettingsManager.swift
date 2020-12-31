//
//  SettingsManager.swift
//  SampleSkybox
//
//  Created by Zehua Chen on 12/26/20.
//
import MetalMath

internal class _SettingsManager {
  var rotationY: Float32 = 0
  let target: SIMD4<Float32> = [0, 0, 0, 1]
  let eye: SIMD4<Float32> = [0, 0, -1, 1]

  var lookAt: simd_float4x4 {
    let rotatedEye = simd_float4x4.rotateY(rotationY.radian) * eye

    return simd_float4x4.look(
      at: [target.x, target.y, target.z],
      from: [rotatedEye.x, rotatedEye.y, rotatedEye.z],
      up: [0, 1, 0])
  }

  var projection: simd_float4x4 {
//    return simd_float4x4(project: .perspective(fov: 1, aspect: 1, near: 0, far: 100))
    return matrix_identity_float4x4
  }
}
