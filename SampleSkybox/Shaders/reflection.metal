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

[[vertex]] vertex_output vertex_func() {
  return vertex_output{};
}

[[fragment]] float4 fragment_func() {
  return float4();
}
