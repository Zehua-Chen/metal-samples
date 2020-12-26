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

  var body: some View {
    SamplePresentation {
      _MetalView()
    } settings: {
      _SettingsView(shadingMethod: $shadingMethod)
    }
  }
}

//struct SampleSkyboxView_Previews: PreviewProvider {
//  static var previews: some View {
//    SampleSkyboxView()
//  }
//}
