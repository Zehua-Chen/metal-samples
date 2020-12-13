//
//  SamplesView.swift
//  MetalSamples
//
//  Created by Zehua Chen on 12/12/20.
//

import SampleKit
import SwiftUI

struct SamplesView: View {
  var tag: SampleTag
  var samples: [Sample]

  var matchedSamples: [Sample] {
    return samples.filter { tag.contains($0.tag) }
  }

  var body: some View {
    NavigationView {
      List(matchedSamples, id: \.name) { sample in
        NavigationLink(destination: sample.body) {
          Text(sample.name)
        }
      }
    }
  }
}

//struct SamplesView_Previews: PreviewProvider {
//  static var previews: some View {
//    SamplesView()
//  }
//}
