//
//  SampleSkyboxView.swift
//  SampleSkybox
//
//  Created by Zehua Chen on 12/12/20.
//

import SampleKit
import SwiftUI

internal struct _BodyView: View {
  @State
  var shadingMethod: _ShadingMethod = .reflection

  @State
  var rotationY: Float32 = 0

  var body: some View {
    SamplePresentation {
      _MetalView(rotationY: rotationY)
    } settings: {
      _SettingsView(shadingMethod: $shadingMethod, rotationY: $rotationY)
    }
  }
}

//struct SampleSkyboxView_Previews: PreviewProvider {
//  static var previews: some View {
//    SampleSkyboxView()
//  }
//}
