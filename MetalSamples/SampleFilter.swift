//
//  SampleFilter.swift
//  MetalSamples
//
//  Created by Zehua Chen on 12/14/20.
//

import SampleKit
import Combine

class SampleFilter: ObservableObject {
  @Published
  var tag: SampleTag = .all
}
