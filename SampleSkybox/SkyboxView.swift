//
//  SampleSkyboxView.swift
//  SampleSkybox
//
//  Created by Zehua Chen on 12/12/20.
//

import SwiftUI
import SampleKit

internal struct _SkyboxView: View {
  @State
  var shadingMethod: _ShadingMethod = .reflection

  var body: some View {
    SamplePresentation {
      _SkyboxMetalView()
    } settings: {
      _SkyboxSettingsView(shadingMethod: $shadingMethod)
    }
    .toolbar {
      ToolbarItem(placement: .primaryAction) {
        Button {
          print("play")
        } label: {
          Image(systemName: "play.fill")
        }
      }
    }
  }
}

//struct SampleSkyboxView_Previews: PreviewProvider {
//  static var previews: some View {
//    SampleSkyboxView()
//  }
//}
