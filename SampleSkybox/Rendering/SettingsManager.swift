//
//  SettingsManager.swift
//  SampleSkybox
//
//  Created by Zehua Chen on 12/26/20.
//

enum Projection {
  case perspective(fov: Float32, aspect: Float32, near: Float32, far: Float32)
  case orthographic
}

extension simd_float4x4 {
  static func view(target: SIMD3<Float32>, from eye: SIMD3<Float32>, up: SIMD3<Float32>) -> Self {
    let v = normalize(target - eye)
    let n = normalize(cross(v, up))
    let u = normalize(cross(n, v))

    return simd_float4x4(rows: [
      SIMD4<Float32>([n.x, n.y, n.z, -dot(n, eye)]),
      SIMD4<Float32>([u.x, u.y, u.z, -dot(u, eye)]),
      SIMD4<Float32>([v.x, v.y, v.z, -dot(v, eye)]),
      SIMD4<Float32>([0, 0, 0, 1]),
    ])
  }

  init(project: Projection) {
    self = matrix_identity_float4x4
  }

  static func rotateY(_ rotateY: Float32) -> Self {
    return simd_float4x4(rows: [
      SIMD4<Float32>([cos(rotateY), 0, sin(rotateY), 0]),
      SIMD4<Float32>([0, 1, 0, 0]),
      SIMD4<Float32>([-sin(rotateY), 0, cos(rotateY), 0]),
      SIMD4<Float32>([0, 0, 0, 1]),
    ])
  }
}

extension Float32 {
  var radian: Float32 {
    return self * .pi / 180
  }
}

internal class _SettingsManager {
  var rotationY: Float32 = 0
  let target: SIMD4<Float32> = [0, 0, 0, 1]
  let eye: SIMD4<Float32> = [0, 0, -1, 1]

  var view: simd_float4x4 {
    let rotatedEye = simd_float4x4.rotateY(rotationY.radian) * eye

    return simd_float4x4.view(
      target: [target.x, target.y, target.z],
      from: [rotatedEye.x, rotatedEye.y, rotatedEye.z],
      up: [0, 1, 0])
  }

  var projection: simd_float4x4 {
    return simd_float4x4(project: .perspective(fov: 1, aspect: 1, near: 0, far: 100))
  }
}
