//
//  _SampleSkyboxSettingsView.swift
//  SampleSkybox
//
//  Created by Zehua Chen on 12/12/20.
//

import SwiftUI

internal struct _SettingsView: View {
  @Binding
  var shadingMethod: _ShadingMethod

  @Binding
  var rotationY: Float32

  var body: some View {
    Form {
      Picker(
        selection: $shadingMethod,
        label: Text("shading_method", bundle: SampleSkybox._bundle)
      ) {
        Text("shading_reflection", bundle: SampleSkybox._bundle).tag(_ShadingMethod.reflection)
        Text("shading_refraction", bundle: SampleSkybox._bundle).tag(_ShadingMethod.refraction)
      }

      Slider(
        value: $rotationY,
        in: 0...360.0,
        minimumValueLabel: Text("0"),
        maximumValueLabel: Text("360")
      ) {
        Text("rotation_y", bundle: SampleSkybox._bundle)
      }
    }
  }
}

//struct _SkyboxSettingsView_Previews: PreviewProvider {
//  @State
//  static var shadingMethod: _ShadingMethod = .refraction
//
//  static var previews: some View {
//    _SkyboxSettingsView(shadingMethod: $shadingMethod)
//  }
//}
