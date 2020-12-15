//
//  SampleSkybox.swift
//  SampleSkybox
//
//  Created by Zehua Chen on 12/12/20.
//

import SampleKit
import SwiftUI

public class SampleSkybox: Sample {
  public override var name: String {
    return "Skybox"
  }

  public override var tag: SampleTag {
    return .textures
  }

  public override var body: AnyView {
    return AnyView(_SkyboxView())
  }
}
