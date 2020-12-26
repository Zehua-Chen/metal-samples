//
//  reflection.metal
//  SampleSkybox
//
//  Created by Zehua Chen on 12/24/20.
//

#include <metal_stdlib>
#include "shader_data.h"

using namespace metal;

struct vertex_output {
  float4 position [[position]];
};

[[vertex]] vertex_output reflection_vertex(
    uint vertex_id [[vertex_id]],
    constant float4 *vertices [[buffer(SkyboxTeapotVertex)]]) {
  vertex_output output;
  output.position = vertices[vertex_id];

  return output;
}

[[fragment]] float4 reflection_fragment() {
  return float4();
}
