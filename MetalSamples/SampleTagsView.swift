//
//  ContentView.swift
//  MetalSamples
//
//  Created by Zehua Chen on 12/12/20.
//

import SampleKit
import SwiftUI

struct SampleTagsView: View {
  var samples: Samples

  @State
  var selection: SampleTag? = .all

  var body: some View {
    return NavigationView {
      List(SampleTag.allTags, id: \.label) { tag in
        NavigationLink(
          destination: SamplesView(tag: tag, samples: samples), tag: tag, selection: $selection
        ) {
          Label(tag.label, systemImage: tag.icon)
        }
      }
      .listStyle(SidebarListStyle())
    }
  }
}

//struct SamplesView_Previews: PreviewProvider {
//  static var previews: some View {
//    SamplesView(samples: Samples(bundle: .main))
//  }
//}
