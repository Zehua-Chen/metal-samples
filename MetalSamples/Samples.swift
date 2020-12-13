//
//  SamplesView.swift
//  MetalSamples
//
//  Created by Zehua Chen on 12/12/20.
//

import SampleKit
import SwiftUI

/// Present a list of samples
struct Samples: View {
  var samples: [SKSample]

  @State
  var selection: String?

  init(samples: [SKSample]) {
    self.samples = samples

  }

  func tags(for sample: SKSample) -> [SampleTag] {
    return SampleTag.allTags.filter { $0.contains(sample.tag) }
  }

  var body: some View {
    NavigationView {
      List(samples, id: \.name) { sample in
        NavigationLink(destination: Sample(sample: sample), tag: sample.name, selection: $selection) {
          VStack(alignment: .leading) {
            Text(sample.name)
              .font(.headline)

            Tags(tags: tags(for: sample))
          }
          .padding(4)
        }
      }
      .listStyle(SidebarListStyle())
      .frame(minWidth: 250)
    }
    .onAppear() {
      selection = self.samples.first?.name
    }
  }
}

//struct SamplesView_Previews: PreviewProvider {
//  static var previews: some View {
//    SamplesView()
//  }
//}
