//
//  SampleSkybox.swift
//  SampleSkybox
//
//  Created by Zehua Chen on 12/12/20.
//

import SampleKit
import SwiftUI

@objc(MSSampleSkybox)
public class SampleSkybox: NSObject, Sample {
  public var name: String = "Skybox"
  public var tag: SampleTag = .textures

  public override required init() {
    super.init()
  }

  public var body: AnyView {
    return AnyView(_SkyboxView())
  }
}
