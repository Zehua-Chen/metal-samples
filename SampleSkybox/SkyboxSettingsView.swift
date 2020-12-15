//
//  _SampleSkyboxSettingsView.swift
//  SampleSkybox
//
//  Created by Zehua Chen on 12/12/20.
//

import SwiftUI

internal struct _SkyboxSettingsView: View {
  @Binding
  var shadingMethod: _ShadingMethod

  @State
  var y: Float = 0

  var body: some View {
    Form {
      Picker("Shading Method", selection: $shadingMethod) {
        Text("Reflection").tag(_ShadingMethod.reflection)
        Text("Refraction").tag(_ShadingMethod.refraction)
      }

      Slider(
        value: $y,
        in: 0...360.0,
        minimumValueLabel: Text("0"),
        maximumValueLabel: Text("360")
      ) {
        Text("Rotation (Y)")
      }
    }
  }
}

//struct _SampleSkyboxSettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        _SampleSkyboxSettingsView()
//    }
//}
