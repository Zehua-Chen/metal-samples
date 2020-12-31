//
//  shader_datas.h
//  MetalSamples
//
//  Created by Zehua Chen on 12/25/20.
//

#ifndef shader_data_h
#define shader_data_h

#ifdef __METAL_VERSION
typedef metal::float4x4 simd_float4x4;
#else
  #include <simd/simd.h>
#endif

typedef struct {
} skybox_teapot_vertex;

typedef struct {
  simd_float4x4 look_at;
  simd_float4x4 projection;
} skybox_camera;

typedef struct {
  simd_float4x4 transform;
} skybox_teapot_transform;

#define SkyboxCameraIndex 0
#define SkyboxTeapotTransformIndex 1
#define SkyboxTeapotVertexIndex 2

#endif /* shader_data_h */
