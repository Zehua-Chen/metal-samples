//
//  SampleSkybox.swift
//  SampleSkybox
//
//  Created by Zehua Chen on 12/12/20.
//

import SampleKit
import SwiftUI

public class SampleSkybox: Sample {
  public var name: String = "Skybox"
  public var tag: SampleTag = .textures

  public required init() {
  }

  public var body: AnyView {
    return AnyView(_SampleSkyboxView())
  }
}
