//
//  SampleFilter.swift
//  MetalSamples
//
//  Created by Zehua Chen on 12/14/20.
//

import Combine
import SampleKit

class SampleFilter: ObservableObject {
  @Published
  var tag: SampleTag = .all
}
