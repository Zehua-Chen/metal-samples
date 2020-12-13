//
//  SamplesView.swift
//  MetalSamples
//
//  Created by Zehua Chen on 12/12/20.
//

import SampleKit
import SwiftUI

struct SamplesView: View {
  var samples: [Sample]
  
  @State
  var selection: String?

  init(samples: [Sample]) {
    self.samples = samples

  }

  func tags(for sample: Sample) -> [SampleTag] {
    return SampleTag.allTags.filter { $0.contains(sample.tag) }
  }

  var body: some View {
    NavigationView {
      List(samples, id: \.name) { sample in
        NavigationLink(destination: SampleView(sample: sample), tag: sample.name, selection: $selection) {
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
