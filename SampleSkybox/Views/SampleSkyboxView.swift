//
//  SampleSkyboxView.swift
//  SampleSkybox
//
//  Created by Zehua Chen on 12/12/20.
//

import SwiftUI

internal struct _SampleSkyboxView: View {
  @State
  var shadingMethod: _ShadingMethod = .reflection

  var body: some View {
    List {
      Section(header: Text("Render")) {
        _SampleSkyboxMetalView()
      }

      Section(header: Text("Settings")) {
        _SampleSkyboxSettingsView(shadingMethod: $shadingMethod)
      }
    }
  }
}

//struct SampleSkyboxView_Previews: PreviewProvider {
//  static var previews: some View {
//    SampleSkyboxView()
//  }
//}
