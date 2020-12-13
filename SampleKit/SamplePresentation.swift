//
//  SamplePresentation.swift
//  SampleKit
//
//  Created by Zehua Chen on 12/12/20.
//

import SwiftUI

public struct SamplePresentation<OutputView: View, SettingsView: View>: View {
  public var output: () -> OutputView
  public var settings: () -> SettingsView

  public init(output: @escaping () -> OutputView, settings: @escaping () -> SettingsView) {
    self.output = output
    self.settings = settings
  }

  public var body: some View {
    List {
      Section(header: Text("Output")) {
        output()
          .frame(minHeight: 400)
      }

      Section(header: Text("Settings")) {
        settings()
      }
    }
    .frame(minWidth: 400)
  }
}

//struct SamplePresentation_Previews: PreviewProvider {
//  static var previews: some View {
//    SamplePresentation()
//  }
//}
