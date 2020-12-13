//
//  TagsView.swift
//  MetalSamples
//
//  Created by Zehua Chen on 12/12/20.
//

import SwiftUI
import SampleKit

struct Tags: View {
  var tags: [SampleTag]
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack {
        ForEach(tags, id: \.rawValue) { tag in
          Label(tag.label, systemImage: tag.icon)
            .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
            .background(RoundedRectangle(cornerRadius: 4).foregroundColor(.gray))
        }
      }
    }
  }
}

//struct TagsView_Previews: PreviewProvider {
//  static var previews: some View {
//    TagsView()
//  }
//}
