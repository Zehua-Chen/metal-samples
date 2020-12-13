//
//  Sample.swift
//  SampleKit
//
//  Created by Zehua Chen on 12/12/20.
//
import SwiftUI

/// A Metal Sample
public protocol Sample: AnyObject {
  /// Name of the sample
  ///
  /// **Optional**
  var name: String { get }

  /// Tag of a sample
  ///
  /// **Optional**; default value is `.all`
  var tag: SampleTag { get }

  /// Body of the sample
  ///
  /// **Optional**
  var body: AnyView { get }

  /// Create a new sample
  init()
}

public extension Sample {
  var tag: SampleTag {
    return .all
  }

  var body: AnyView {
    AnyView(Text("\(name) Not Implemented"))
  }
}
