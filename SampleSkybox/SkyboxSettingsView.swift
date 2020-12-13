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
  
  var body: some View {
    Form {
      Picker("Shading Method", selection: $shadingMethod) {
        Text("Reflection").tag(_ShadingMethod.reflection)
        Text("Refraction").tag(_ShadingMethod.refraction)
      }
    }
  }
}

//struct _SampleSkyboxSettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        _SampleSkyboxSettingsView()
//    }
//}
