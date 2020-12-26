//
//  SampleSkybox.swift
//  SampleSkybox
//
//  Created by Zehua Chen on 12/12/20.
//

import SampleKit
import SwiftUI

public class SampleSkybox: Sample {
  internal static var _bundle: Bundle = Bundle(for: SampleSkybox.self)

  public override var name: String {
    return NSLocalizedString(
      "skybox",
      tableName: nil,
      bundle: SampleSkybox._bundle,
      value: "Skybox",
      comment: "Skybox")
  }

  public override var tag: SampleTag {
    return .textures
  }

  public override var body: AnyView {
    return AnyView(_BodyView())
  }
}
