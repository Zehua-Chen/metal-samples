//
//  SampleView.swift
//  MetalSamples
//
//  Created by Zehua Chen on 12/12/20.
//

import SampleKit
import SwiftUI

struct SampleView: View {
  var sample: Sample

  var body: some View {
    sample.body
      .navigationSubtitle(sample.name)
  }
}

//struct SamplesView_Previews: PreviewProvider {
//  static var previews: some View {
//    SamplesView()
//  }
//}
